class ProfilesController < ApplicationController
  before_action :find_user

  def show
    authorize @user
  end

  def edit
    authorize @user
  end

  def update
    authorize @user
  end

  private

  def find_user
    @user = User.find(params[:id])
  end
end
