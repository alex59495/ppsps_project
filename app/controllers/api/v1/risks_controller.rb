class Api::V1::RisksController < Api::V1::BaseController
  def index
    # Renvois la liste des sous-traitants qui n'ont pas encore été sélectionnés
    if params[:ppsps_id] == ''
      @risk = policy_scope(Risk.all)
      authorize @risk
    else
      selected_risk = SelectedRisk.where(ppsp_id: params[:ppsps_id])
      @risk = policy_scope(Risk).where.not(id: selected_risk.map(&:risk_id))
      authorize @risk
    end
  end

  def selected_risk
    # Renvois la liste des sous-traitants aui ont déjà été sĺectionnés
    selected_risk = SelectedRisk.where(ppsp_id: params[:ppsps_id])
    @risk = policy_scope(Risk).where(id: selected_risk.map(&:Risk_id))
    authorize @risk
  end

  def destroy
    @selected_Risk = SelectedRisk.where(ppsp_id: params[:ppsps_id], Risk_id: params[:id]).first
    authorize @selected_Risk
    @selected_Risk.destroy
    head :no_content
  end
end
