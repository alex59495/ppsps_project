class Api::V1::WorkersController < Api::V1::BaseController
  def conductors
    selected_workers_ids = Conductor.where(user_id: current_user.id, ppsp_id: nil).pluck(:worker_id)
    @workers = policy_scope(Worker).where(conductor: true)
    authorize @workers
  end

  def lifesavers
    # Renvois la liste des lifesavers qui n'ont pas encore été sélectionnés
    if params[:ppsps_id] == ''
      @lifesavers = policy_scope(Worker).where(lifesaver: true)
      authorize @lifesavers
    else
      selected_lifesavers = SelectedLifesaver.where(ppsp_id: params[:ppsps_id])
      @lifesavers = policy_scope(Worker).where(lifesaver: true).where.not(id: selected_lifesavers.map(&:worker_id))
      authorize @lifesavers
    end
  end

  def selected_lifesavers
    # Renvois la liste des lifesavers aui ont déjà été sĺectionnés
    selected_lifesavers = SelectedLifesaver.where(ppsp_id: params[:ppsps_id])
    @lifesavers = policy_scope(Worker).where(lifesaver: true).where(id: selected_lifesavers.map(&:worker_id))
    authorize @lifesavers
  end

  def destroy_selected_lifesavers
    @selected_lifesavers = SelectedLifesaver.where(ppsp_id: params[:ppsps_id], worker_id: params[:lifesaver_id]).first
    authorize @selected_lifesavers
    @selected_lifesavers.destroy
    head :no_content
  end
end
