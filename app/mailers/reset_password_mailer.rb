class ResetPasswordMailer < ApplicationMailer
  default from: "example@gmail.com"
  layout "mailer"

  def reset_password_email account
    @account = account
    @auth_token = JsonWebToken.encode account_id: account.id, email: account.email
    mail to: @account.email, subject: I18n.t("mailers.reset_password.subject")
  end
end
