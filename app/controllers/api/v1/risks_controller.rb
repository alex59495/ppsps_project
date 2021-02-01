class Api::V1::RisksController < Api::V1::BaseController
  def index
    # Renvois la liste des sous-traitants qui n'ont pas encore été sélectionnés
    if params[:ppsps_id] == ''
      @risks = policy_scope(Risk.all)
      authorize @risks
    else
      selected_risks = SelectedRisk.where(ppsp_id: params[:ppsps_id])
      @risks = policy_scope(Risk).where.not(id: selected_risks.map(&:risk_id))
      authorize @risks
    end
  end

  def selected_risks
    # Renvois la liste des sous-traitants aui ont déjà été sĺectionnés
    selected_risks = SelectedRisk.where(ppsp_id: params[:ppsps_id])
    @risks = policy_scope(Risk).where(id: selected_risks.map(&:risk_id))
    authorize @risks
  end

  def destroy
    @selected_risk = SelectedRisk.where(ppsp_id: params[:ppsps_id], risk_id: params[:id]).first
    authorize @selected_risk
    @selected_risk.destroy
    head :no_content
  end
end
