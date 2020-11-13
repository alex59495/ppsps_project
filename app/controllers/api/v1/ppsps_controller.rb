class Api::V1::PpspsController < Api::V1::BaseController
  before_action :find_ppsp, only: [:show, :destroy]
  
  def index
    # Receive a params from the Fetch request (javascript/ppsp-react/actions/index.js) in order to know if we are :
    # - On the show page (in this case show_user exist and it has the value of the user.id of the show page we are looking at)
    # - On the index page (in this case the show_user is empty)
    if params[:show_user].nil? || params[:show_user] == ''
      users = User.where(company: current_user.company)
    else
      users = User.where(id: params[:show_user])
    end
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
