class UserMailer < Devise::Mailer
  helper :application # gives access to all helpers defined within `application_helper`.
  include Devise::Controllers::UrlHelpers # Optional. eg. `confirmation_url`
  default template_path: 'users/mailer' # to make sure that your mailer uses the devise views

  # If you want to rewrite the default deviser mailer views uncomment these lines below
  # def headers_for(action, opts = {})
  #   super.merge!(template_path: 'users/mailer')
  # end

  def welcome_reset_password_instructions(user)
    @resource = user
    create_reset_password_token(user)
    mail(to: user.email, subject: 'Changer votre mot de passe')
  end

  private

  def create_reset_password_token(user)
    raw, hashed = Devise.token_generator.generate(User, :reset_password_token)
    @token = raw
    user.reset_password_token = hashed
    user.reset_password_sent_at = Time.now.utc
    user.save
  end
end
