class Api::V1::PpspsController < Api::V1::BaseController
  before_action :find_ppsp, only: [:show, :destroy]
  
  def index
    users = User.where(company: current_user.company)
    @ppsps = policy_scope(Ppsp.where(user: users))
  end

  def show
    authorize @ppsp
    render json: @ppsp
  end

  def destroy
    authorize @ppsp
    @ppsp.destroy
    head :no_content
  end

  private
  def find_ppsp
    @ppsp = Ppsp.find(params[:id])
  end
end
