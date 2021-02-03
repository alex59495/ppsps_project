class Api::V1::AltitudeWorksController < Api::V1::BaseController
  def index
    # Renvoie la liste des altitude_works qui n'ont pas encore été sélectionnés
    if params[:ppsps_id] == ''
      @altitude_works = policy_scope(AltitudeWork)
      authorize @altitude_works
    else
      selected_altitude_works = SelectedAltitude.where(ppsp_id: params[:ppsps_id])
      @altitude_works = policy_scope(AltitudeWork).where.not(id: selected_altitude_works.map(&:altitude_work_id))
      authorize @altitude_works
    end
  end

  def selected_altitude_works
    # Renvois la liste des altitude_works aui ont déjà été sĺectionnés
    selected_altitude_works = SelectedAltitude.where(ppsp_id: params[:ppsps_id])
    @altitude_works = policy_scope(AltitudeWork).where(id: selected_altitude_works.map(&:altitude_work_id))
    authorize @altitude_works
  end

  def destroy_selected_altitudes
    @selected_altitude_work = SelectedAltitude.where(ppsp_id: params[:ppsps_id], altitude_work_id: params[:altitude_id]).first
    authorize @selected_altitude_work
    @selected_altitude_work.destroy
    head :no_content
  end
end
