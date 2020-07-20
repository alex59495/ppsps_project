class PpspsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_ppsp, only: [ :update, :show, :destroy, :edit ]

  def index
    @ppsps = Ppsp.all
  end

  def new
    @ppsp = Ppsp.new
    @companies = Company.all
  end

  def show
  end

  def create
    @ppsp = Ppsp.new(params_ppsp)
    if @ppsp.save
      redirect_to ppsps_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @ppsp.update(params_ppsp)
      redirect_to ppsps_path
    else
      render :edit
    end
  end

  def destroy
    @ppsp.destroy
    redirect_to ppsps_path
  end

  private
  def params_ppsp
    params.require(:ppsp).permit(:address, :start, :end, :nature, :workforce)
  end

  def find_ppsp
    @ppsp = Ppsp.find(params[:id])
  end

end
