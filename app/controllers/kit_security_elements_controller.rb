class KitSecurityElementsController < ApplicationController
  before_action :params_security_element, only: :create
  before_action :find_element, only: :destroy
  def create
    @kit_security_element = KitSecurityElement.new(params_security_element)
    @kit_security_element.company = current_user.company
    @company = @kit_security_element.company
    authorize @kit_security_element
    if @kit_security_element.save
      respond_to do |format|
        flash.now[:notice_ok] = "Ajouté"
        format.js { render 'kit_security_elements/create.js.erb' }
      end
    else
      respond_to do |format|
        format.js { render 'kit_security_elements/error.js.erb' }
      end
    end
  end

  def destroy
    authorize @element
    @element.destroy
    redirect_to edit_company_path(@company)
  end

  private

  def params_security_element
    params.require(:kit_security_element).permit(:name, :number)
  end

  def find_element
    @element = KitSecurityElement.find(params[:id])
  end
end
