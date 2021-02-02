class Api::V1::MachinesController < Api::V1::BaseController
  def index
    conductor_ids = Conductor.where(user_id: current_user.id, ppsp_id: nil).pluck(:machine_id)
    @machines = policy_scope(Machine.all.where.not(id: conductor_ids))
  end
end
