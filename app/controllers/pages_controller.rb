class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[home contact]

  def home
    @navbar = true
  end

  def database
    authorize Page
  end

  def contact
    name = params[:name]
    email = params[:email]
    description = params[:description]
    contact = { name: name, email: email, description: description }
    ContactMailer.contact(contact).deliver_now
    redirect_to root_path
  end
end
