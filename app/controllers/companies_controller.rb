class CompaniesController < ApplicationController
  before_action :find_company, only: %i[edit update destroy_logo]

  def edit
    @kit_security_element = KitSecurityElement.new
    authorize @company
  end

  def update
    authorize @company
    if @company.update(params_company)
      redirect_to profile_path(current_user)
    else
      render 'profiles/edit'
    end
  end

  def destroy_logo
    authorize @company
    @user = current_user
    if @company.logo.purge.nil?
      respond_to do |format|
        format.js { render 'companies/destroy_logo' }
      end
    else
      # Que faire si probleme ?
    end
  end

  private

  def params_company
    params.require(:company).permit(:logo, :content_secu)
  end

  def find_company
    @company = Company.find(params[:id])
  end
end
