class KitSecurityElementsController < ApplicationController
  before_action :params_security_element, only: :create
  before_action :find_element, only: :destroy
  def create
    kit_element = KitSecurityElement.new(params_security_element)
    @user = current_user
    kit_element.company = @user.company
    authorize kit_element
    if kit_element.save
      respond_to do |format|
        format.js { 'kit_security_elements/create.js.erb' }
      end
    else
      # render
    end
  end

  def destroy
    authorize @element
    @element.destroy
    user_id = params[:user_id]
    redirect_to edit_profile_path(user_id)
  end

  private

  def params_security_element
    params.require(:kit_security_element).permit(:name, :number)
  end

  def find_element
    @element = KitSecurityElement.find(params[:id])
  end
end
