class SubcontractorsController < ApplicationController
  before_action :find_subcontractor, only: :destroy
  before_action :find_ppsp

  def create
    @subcontractor = Subcontractor.new(params_subcontractor)
    @subcontractor.ppsp_id = @ppsp.id
    authorize @subcontractor
      if @subcontractor.save
      # Respond with the view subcontractor/create.js.erb to close the modal and come back to the form
        respond_to do |format|
          format.js {}
        end
      else
        # Respond with the .js.erb to print the modal with errors
        respond_to do |format|
          format.js { render 'ppsps/modal_subcontractor' }
        end
      end
  end

  def destroy
    authorize @subcontractor
    @subcontractor.destroy
    redirect_to informations_supplementaires_ppsp_path(@ppsp)
  end

  private
  def params_subcontractor
    params.require(:subcontractor).permit(:address, :name, :work, 
    :responsible_name, :responsible_phone, :responsible_email, :ppsp_id)
  end

  def find_subcontractor
    @subcontractor = Subcontractor.find(params[:id])
  end

  def find_ppsp
    @ppsp = Ppsp.find(params[:ppsp_id])
  end
end
