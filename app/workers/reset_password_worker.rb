class ResetPasswordWorker < MailerWorker
  def perform account_id
    account = Account.find account_id
    send_mailer ResetPasswordMailer.reset_password_email(account), {}
  end
end
