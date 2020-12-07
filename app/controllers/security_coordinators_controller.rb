class SecurityCoordinatorsController < ApplicationController
  before_action :find_security_coordinator, only: [ :update, :show, :destroyed, :edit ]

  def index
    authorize SecurityCoordinator
    @security_coordinators = policy_scope(SecurityCoordinator.where(is_destroyed: false))
    @security_coordinator = SecurityCoordinator.new
  end

  def create
    @security_coordinator = SecurityCoordinator.new(params_security_coordinator)
    @security_coordinator.company = current_user.company
    authorize @security_coordinator
    if @security_coordinator.save
      # Create an ordered list to use in the view 'security_coordinator/_form_field_security_coordinator'
      @security_coordinators = SecurityCoordinator.all.sort_by { |s| s.name.downcase }
      # Respond with the view security_coordinator/create.js.erb to close the modal and come back to the form
      respond_to do |format|
        format.js {}
      end
    else
      # Respond with the .js.erb to print the modal with errors
      respond_to do |format|
        format.js { render 'ppsps/modal_security_coordinator' }
      end
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

  def destroyed
    authorize @security_coordinator
    @security_coordinator.is_destroyed = true
    if @security_coordinator.save
      redirect_to security_coordinators_path
    else
      flash.now[:error] = "L'élément n'a pas pu être supprimé"
    end
  end

  private
  def params_security_coordinator
    params.require(:security_coordinator).permit(:address, :name, :representative, :email, :phone, :company)
  end

  def find_security_coordinator
    @security_coordinator = SecurityCoordinator.find(params[:id])
  end
end
