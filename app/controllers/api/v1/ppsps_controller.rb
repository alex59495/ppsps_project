class Api::V1::PpspsController < Api::V1::BaseController
  
  def index
    users = User.where(company: current_user.company)
    @ppsps = policy_scope(Ppsp.where(user: users))
  end

  def show
    ppsp = Ppsp.find(params[:id])
    authorize @ppsp
    render json: ppsp
  end

end
