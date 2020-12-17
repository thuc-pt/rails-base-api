class RegistrationWorker < MailerWorker
  def perform account_id
    account = Account.find account_id
    send_mailer RegistrationMailer.register_account_email(account), {}
  end
end
