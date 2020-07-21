class PpspsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_ppsp, only: [ :update, :show, :destroy, :edit ]

  def index
    @ppsps = policy_scope(Ppsp.where(user: current_user))
  end

  def new
    @ppsp = Ppsp.new
    authorize @ppsp
    @companies = Company.all
  end

  def show
    authorize @ppsp
  end

  def create
    @ppsp = Ppsp.new(params_ppsp)
    @ppsp.user = current_user
    authorize @ppsp
    if @ppsp.save
      redirect_to ppsps_path
    else
      render :new
    end
  end

  def edit
    authorize @ppsp
  end

  def update
    authorize @ppsp
    if @ppsp.update(params_ppsp)
      redirect_to ppsps_path
    else
      render :edit
    end
  end

  def destroy
    authorize @ppsp
    @ppsp.destroy
    redirect_to ppsps_path
  end

  private
  def params_ppsp
    params.require(:ppsp).permit(:address, :start, :end, :nature, :workforce, :company_id)
  end

  def find_ppsp
    @ppsp = Ppsp.find(params[:id])
  end

end
