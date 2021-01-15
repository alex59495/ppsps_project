class SubcontractorsController < ApplicationController
  before_action :find_subcontractor, only: :destroy
  before_action :find_ppsp

  def create
    @subcontractor = Subcontractor.new(params_subcontractor)
    @subcontractor.ppsp_id = @ppsp.id
    # Add thos lines in order to re-render the selection card on the informations_supplementaires page
    @selected_installation_active = SelectedInstallation.where(ppsp_id: @ppsp.id)
    @selected_altitude_active = SelectedAltitude.where(ppsp_id: @ppsp.id)
    @selected_risk_active = SelectedRisk.where(ppsp_id: @ppsp.id)
    @selected_installation_active.count > 0 || @selected_altitude_active.count > 0 || @selected_risk_active.count > 0 || @ppsp.subcontractors.count > 0 ? @show_select = true : @show_select = false

    authorize @subcontractor
    if @subcontractor.save
      respond_to do |format|
        format.html { redirect_to informations_supplementaires_ppsp_path(@ppsp) }
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
