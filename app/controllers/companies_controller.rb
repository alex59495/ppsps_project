class CompaniesController < ApplicationController
  before_action :find_company, only: %i[edit update destroy_logo destroy_cover edit_content_secu]

  def edit
    @kit_security_element = KitSecurityElement.new
    @user = current_user
    authorize @company
  end

  def update
    authorize @company
    if @company.update(params_company)
      redirect_to profile_path(current_user)
      flash[:notice_ok] = 'Les modifications ont bien été prises en compte'
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

  def destroy_cover
    authorize @company
    @user = current_user
    if @company.cover_image.purge.nil?
      respond_to do |format|
        format.js { render 'companies/destroy_cover' }
      end
    else
      # Que faire si probleme ?
    end
  end

  private

  def params_company
    params.require(:company).permit(:logo, :content_secu, :name, :address, :representative, :cover_image)
  end

  def find_company
    @company = Company.find(params[:id])
  end
end
