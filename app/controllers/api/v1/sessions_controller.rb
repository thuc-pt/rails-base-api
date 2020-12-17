module Api::V1
  class SessionsController < ApiDocsController
    def sign_in
      account = Account.find_by email: account_params[:email]
      raise ApiError::AccountNotFound unless account

      raise ApiError::AccountUnauthenticated unless account&.activated?

      raise ApiError::LoginWrong unless account&.authenticate(account_params[:password])

      process_account_token_and_response account
    end

    def sign_up
      ActiveRecord::Base.transaction do
        account = Account.create! account_params.merge(password_normal: params[:password])
        RegistrationWorker.perform_async account.id
      end
    end

    def verify_account
      account = Account.find_by email: params[:email]
      raise ApiError::AccountNotFound unless account

      raise ApiError::AuthTokenNotFound if params[:auth_token].blank? || token_not_match(params[:auth_token], account)

      raise ApiError::AccountAuthenticated if account.activated

      account.update! activated: true, activated_at: Time.zone.now
      process_account_token_and_response account
    end

    def forgot_password
      account = Account.find_by email: account_params[:email]
      raise ApiError::AccountNotFound unless account

      account.update! reset_password_sent_at: Time.zone.now
      ResetPasswordWorker.perform_async account.id
    end

    def password_reset
      account = Account.find_by email: params[:email]
      raise ApiError::AccountNotFound unless account

      if params[:auth_token].blank? || account&.reset_password_sent_at.blank? ||
          token_not_match(params[:auth_token], account)
        raise ApiError::AuthTokenNotFound
      end

      account.update! password_reset_params.merge(password_normal: params[:password], reset_password_sent_at: nil)
      process_account_token_and_response account
    end

    def sign_out
      auth_token = JWT.encode({exp: Time.zone.now.to_i}, Rails.application.secrets.secret_key_base)
      json_response(:ok, token: auth_token)
    end

    private
    def account_params
      params.permit :email, :password, :password_confirmation, :agreed_rule
    end

    def password_reset_params
      params.permit :password, :password_confirmation
    end

    def token_not_match auth_token, account
      decode = JsonWebToken.decode(auth_token).first
      true unless decode.try(:[], "account_id") == account.id && decode.try(:[], "email") == account.email
    rescue StandardError => _e
      true
    end
  end
end
