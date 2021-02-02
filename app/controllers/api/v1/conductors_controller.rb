class Api::V1::ConductorsController < Api::V1::BaseController
  def create
    @conductor = Conductor.new(worker_id: params[:worker_id], machine_id: params[:machine_id], user_id: current_user.id)
    authorize @conductor
    if @conductor.save
      head :no_content
    else
      render_error
    end
  end

  def destroy
    @conductor = Conductor.find(params[:id])
    authorize @conductor
    @conductor.destroy
    head :no_content
  end

  def index
    @conductors = policy_scope(Conductor.all)
  end

  private

  def render_error
    render json: { errors: @conductor.errors.full_messages },
           status: :unprocessable_entity
  end
end
