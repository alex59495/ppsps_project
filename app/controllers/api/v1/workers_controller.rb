class Api::V1::WorkersController < Api::V1::BaseController
  def index
    selected_workers_ids = Conductor.where(user_id: current_user.id, ppsp_id: nil).pluck(:worker_id)
    @workers = policy_scope(Worker.all.where(conductor: true))
  end
end
