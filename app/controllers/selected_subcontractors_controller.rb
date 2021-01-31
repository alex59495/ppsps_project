class SelectedSubcontractorsController < ApplicationController
  def create
  end

  def destroy
    @selected_subcontractors = SelectedSubcontractor.includes(:ppsp).where('ppsp_id = ? AND subcontractor_id = ?', params[:id], params[:sub_id]).first
    @selected_subcontractors.destroy
    @ppsp = Ppsp.find(params[:id])

    # Modifier la liste des sous-traitants affichés en fonction des sous-traitants déjà sélectionnés
    selected_subcontractors = SelectedSubcontractor.where(ppsp_id: params[:id])
    @subcontractors = Subcontractor.where.not(id: selected_subcontractors.map(&:subcontractor_id))

    authorize @selected_subcontractors
    respond_to do |format|
      format.js { render 'subcontractors/destroy_selected' }
    end
  end
end
