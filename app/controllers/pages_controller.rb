class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[home contact]

  def home
  end

  def database
    authorize Page
  end

  def contact
    name = params[:name]
    email = params[:email]
    description = params[:description]
    contact = { name: name, email: email, description: description }
    if ContactMailer.contact(contact).deliver_now
      redirect_to root_path, sent: true
    else
      redirect_to root_path, not_sent: true
    end
  end
end
