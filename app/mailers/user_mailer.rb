class UserMailer < ApplicationMailer
  def contact_us(admin_email,client_email,client_name,client_message)
    @email = client_email
    @name = client_name
    @message = client_message
    mail(to: admin_email, subject: 'Пользователь ' + client_name + ' оставил сообщение на сайте domhimik.ru')
  end
end
