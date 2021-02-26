class Api::V1::ConductorsController < Api::V1::BaseController
  def show
    @conductor = Conductor.find(params[:id])
    authorize @conductor
  end

  def create
    @conductor = Conductor.new(params_conductor)
    @conductor.user = current_user
    authorize @conductor
    if @conductor.save
      render :show
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
    ppsps_id = params[:ppsps_id].empty? ? nil : params[:ppsps_id]
    @conductors = policy_scope(Conductor.all.where(ppsp_id: ppsps_id))
  end

  private

  def params_conductor
    params.require(:conductor).permit(:worker_id, :machine_id, :ppsp_id)
  end

  def render_error
    render json: { errors: @conductor.errors.full_messages },
           status: :unprocessable_entity
  end
end
