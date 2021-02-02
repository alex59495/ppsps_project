class Api::V1::SubcontractorsController < Api::V1::BaseController
  def index
    # Renvois la liste des sous-traitants qui n'ont pas encore été sélectionnés
    if params[:ppsps_id] == ''
      @subcontractors = policy_scope(Subcontractor.all)
      authorize @subcontractors
    else
      selected_subcontractors = SelectedSubcontractor.where(ppsp_id: params[:ppsps_id])
      @subcontractors = policy_scope(Subcontractor).where.not(id: selected_subcontractors.map(&:subcontractor_id))
      authorize @subcontractors
    end
  end

  def selected_subcontractors
    # Renvois la liste des sous-traitants aui ont déjà été sĺectionnés
    selected_subcontractors = SelectedSubcontractor.where(ppsp_id: params[:ppsps_id])
    @subcontractors = policy_scope(Subcontractor).where(id: selected_subcontractors.map(&:subcontractor_id))
    authorize @subcontractors
  end

  def destroy
    @selected_subcontractor = SelectedSubcontractor.where(ppsp_id: params[:ppsps_id], subcontractor_id: params[:id]).first
    authorize @selected_subcontractor
    @selected_subcontractor.destroy
    head :no_content
  end
end
