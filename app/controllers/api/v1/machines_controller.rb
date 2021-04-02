class Api::V1::MachinesController < Api::V1::BaseController
  def index
    ppsps_id = params[:ppsps_id].empty? ? nil : params[:ppsps_id]
    conductor_ids = Conductor.where(user_id: current_user.id, ppsp_id: ppsps_id).pluck(:machine_id)
    @machines = policy_scope(Machine.all.where.not(id: conductor_ids).where(machine_category: MachineCategory.find_by(name: params[:category])))
  end

  def categories
    conductor_ids = Conductor.where(user_id: current_user.id, ppsp_id: params[:ppsps_id]).pluck(:machine_id)
    @categories = MachineCategory.includes(:machines).where.not(machines: { id: conductor_ids })
    authorize @categories
  end
end
