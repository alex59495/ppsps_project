class Api::V1::WorkersController < Api::V1::BaseController
  def index
    @workers = policy_scope(Worker.all).where(conductor: true)
  end
end
