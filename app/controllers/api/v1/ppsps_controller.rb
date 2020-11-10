class Api::V1::PpspsController < Api::V1::BaseController
  def index
    @ppsps = policy_scope(Ppsp.all)
  end

  def show
    ppsp = Ppsp.find(params[:id])
    render json: ppsp
  end

end
