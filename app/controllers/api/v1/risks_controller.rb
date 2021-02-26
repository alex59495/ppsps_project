class Api::V1::RisksController < Api::V1::BaseController
  def index
    # Renvoie la liste des risques qui n'ont pas encore été sélectionnés
    if params[:ppsps_id] == ''
      @risks = policy_scope(Risk).includes([:risk_type])
      authorize @risks
    else
      selected_risks = SelectedRisk.where(ppsp_id: params[:ppsps_id])
      @risks = policy_scope(Risk).includes([:risk_type]).where.not(id: selected_risks.map(&:risk_id))
      authorize @risks
    end
  end

  def selected_risks
    # Renvois la liste des risques aui ont déjà été sĺectionnés
    selected_risks = SelectedRisk.where(ppsp_id: params[:ppsps_id])
    @risks = policy_scope(Risk).where(id: selected_risks.map(&:risk_id))
    authorize @risks
  end

  def destroy_selected_risks
    @selected_risk = SelectedRisk.where(ppsp_id: params[:ppsps_id], risk_id: params[:risk_id]).first
    authorize @selected_risk
    @selected_risk.destroy
    head :no_content
  end
end
