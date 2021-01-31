class Api::V1::SubcontractorsController < Api::V1::BaseController
  def index
    # Renvois la liste des sous-traitants qui n'ont pas encore été sélectionnés
    selected_subcontractors = SelectedSubcontractor.where(ppsp_id: params[:ppsp_id])
    @subcontractors = policy_scope(Subcontractor).where.not(id: selected_subcontractors.map(&:subcontractor_id))
    authorize @subcontractors
  end

  def selected_subcontractors
    # Renvois la liste des sous-traitants qui n'ont pas encore été sélectionnés
    selected_subcontractors = SelectedSubcontractor.where(ppsp_id: params[:ppsp_id])
    @subcontractors = policy_scope(Subcontractor).where(id: selected_subcontractors.map(&:subcontractor_id))
    authorize @subcontractors
  end
end
