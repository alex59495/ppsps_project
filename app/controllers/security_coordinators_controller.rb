class SecurityCoordinatorsController < ApplicationController
  before_action :find_security_coordinator, only: [ :update, :show, :destroy, :edit ]

  def index
    @security_coordinators = policy_scope(SecurityCoordinator)
  end

  def show
    authorize @security_coordinator
  end

  def new
    @security_coordinator = SecurityCoordinator.new
    authorize @security_coordinator
  end

  def create
    @security_coordinator = SecurityCoordinator.new(params_security_coordinator)
    authorize @security_coordinator
    if @security_coordinator.save
      redirect_to new_ppsp_path
    else
      render :new
    end
  end

  def edit
    authorize @security_coordinator
  end

  def update
    authorize @security_coordinator
    if @security_coordinator.update(params_security_coordinator)
      redirect_to security_coordinators_path
    else
      render :edit
    end
  end

  private
  def params_security_coordinator
    params.require(:security_coordinator).permit(:address, :name, :phone, :email, :phone)
  end

  def find_security_coordinator
    @security_coordinator = SecurityCoordinator.find(params[:id])
  end
end
