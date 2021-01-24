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
    if params.key?(:company)
      @company.logo = params.require(:user).require(:company).require(:logo)
      @company.save!
    end
    if @user.update!(user_params)
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
end
