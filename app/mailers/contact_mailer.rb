class ContactMailer < ApplicationMailer
  helper :application # gives access to all helpers defined within `application_helper`.
  default template_path: 'contact/mailer'

  def contact(contact)
    @contact = contact
    return unless @contact.keys == %i[name email description]

    mail(to: @contact[:email], subject: 'Une nouvelle demande de test a été effectuée')
  end
end
