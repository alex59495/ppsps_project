class ProfilesController < ApplicationController
  before_action :find_user

  def show
    authorize @user
  end

  def edit
    authorize @user
    @company = @user.company
  end

  def update
    @user.user_update = true
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
end
