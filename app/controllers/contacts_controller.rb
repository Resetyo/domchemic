class ContactsController < ApplicationController
  def create
    @contact = Contact.new(contact_params)
    if params['g-recaptcha-response'].present?
      if @contact.save
        begin
          UserMailer.contact_us(
              Setting.get_value(:admin_email),
              @contact.email,
              @contact.name,
              @contact.message
          ).deliver_now
          flash[:notice] = 'Письмо отправлено, менеджер перезвонит вам в ближайшее время'
        rescue => e
          flash[:error] = "Произошла ошибка при отправке письма. Пожалуйста, свяжитесь с нами по телефону <a href='tel:205-50-53'>205-50-53</a>"
        end
      else
        flash[:error] = "Произошла ошибка при сохранении данных. Пожалуйста, свяжитесь с нами по телефону <a href='tel:205-50-53'>205-50-53</a>"
      end
    else
      flash[:error] = "Подтвердите, что вы не робот, поставив галочку в конце формы"
    end

    redirect_to root_path
  end

  private

    def contact_params
      params.require(:contact).permit(:name,:email,:message)
    end
end
