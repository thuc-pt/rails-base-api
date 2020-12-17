class RegistrationMailer < ApplicationMailer
  default from: "example@gmail.com"
  layout "mailer"

  def register_account_email account
    @account = account
    @auth_token = JsonWebToken.encode account_id: account.id, email: account.email
    mail to: @account.email, subject: I18n.t("mailers.register_account.subject")
  end
end
