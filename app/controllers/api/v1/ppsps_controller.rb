class Api::V1::PpspsController < Api::V1::BaseController
  before_action :find_ppsp, only: %i[show destroy]

  def index
    # Receive a params from the Fetch request (javascript/ppsp-react/actions/index.js) in order to know if we are :
    # - On the show page (in this case show_user exist and it has the value of the user.id of the show page we are looking at)
    # - On the index page (in this case the show_user is empty)
    if params[:show_user].nil? || params[:show_user] == ''
      users = User.where(company: current_user.company).order(updated_at: :desc)
    else
      users = User.where(id: params[:show_user]).order(updated_at: :desc)
    end
    # Use the Kaminari gem to handle the pagination request to limit the number of element we display
    @ppsps = params[:page] ? policy_scope(Ppsp.includes(:user).where(user: users).page(params[:page]).per(12).order(updated_at: :desc)) : policy_scope(Ppsp.includes(:user).where(user: users).order(updated_at: :desc))

    # If params search exist then will filter with reference and/or user first and last names
    @ppsps = params[:search].present? ? @ppsps.where("CONCAT_WS(' ', users.first_name, users.last_name) ILIKE :query or ppsps.reference ILIKE :query", query: "%#{params[:search]}%").references(:users) : @ppsps
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
