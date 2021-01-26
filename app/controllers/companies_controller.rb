class CompaniesController < ApplicationController
  before_action :find_company, only: %i[update destroy_logo]

  def update
    authorize @company
    if @company.update(params_company)
      redirect_to edit_profile_path(current_user)
    else
      # Que faire si probleme ?
    end
  end

  def destroy_logo
    authorize @company
    if @company.logo.purge.nil?
      respond_to do |format|
        # render destroy_logo.js.erb
        format.js { render 'companies/destroy_logo' }
        # format.html { redirect_to edit_profile_path(current_user) }
      end
    else
      # Que faire si probleme ?
    end
  end

  private

  def params_company
    params.require(:company).permit(:logo)
  end

  def find_company
    @company = Company.find(params[:id])
  end
end
