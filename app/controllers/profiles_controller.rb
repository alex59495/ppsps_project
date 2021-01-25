class ProfilesController < ApplicationController
  before_action :find_user

  def show
    authorize @user
  end

  def edit
    authorize @user
    @company = @user.company || @user.build_company
  end

  def update
    @user.user_update = true
    @company = @user.company
    # Verify if the company logo is entered, if yes update the logo
    if params.require(:user).require(:company).key?(:logo)
      # Delete the attached existing element (if there is one)
      @company.logo.purge
      @company.update(company_params)
    end
    @company.update(company_params) if params.require(:user).require(:company).key?(:content_secu)
    if @user.update(user_params)
      redirect_to profile_path(@user)
    else
      render :edit
    end
    authorize @user
  end

  private

  def find_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email)
  end

  def company_params
    params.require(:user).require(:company).permit(:logo, :content_secu)
  end
end
