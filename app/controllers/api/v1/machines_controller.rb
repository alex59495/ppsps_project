class Api::V1::MachinesController < Api::V1::BaseController
  def index
    @machines = policy_scope(Machine.all)
  end
end
