class SelectedSubcontractorsController < ApplicationController
  def create
  end

  def destroy
    @selected_subcontractors = SelectedSubcontractor.includes(:ppsp).where('ppsp_id = ? AND subcontractor_id = ?', params[:id], params[:sub_id]).first
    @selected_subcontractors.destroy
    @ppsp = Ppsp.find(params[:id])
    authorize @selected_subcontractors
    respond_to do |format|
      format.js { render 'subcontractors/destroy_selected' }
    end
  end
end
