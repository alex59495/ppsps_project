class SecurityCoordinatorsController < ApplicationController
  before_action :find_security_coordinator, only: [ :update, :show, :destroyed, :edit ]

  def index
    authorize SecurityCoordinator
    if params[:query]
      @security_coordinators = policy_scope(SecurityCoordinator.search_security_coordinator(params[:query]))
      @search = 'search'
      # We are using form_with in the index view so it respond with ajax, to handle the response we have to activate a format response
      respond_to do |format|
        # Respond with the index.js.erb
        format.js {}
      end
    else
      @security_coordinators = policy_scope(SecurityCoordinator.all)
      @search = 'none'
      # Must be able to respond in HTML (when load the page) and JS (when click on button Show all databse)
      respond_to do |format|
        format.html {}
        format.js {}
      end
    end

    init_infinite_loop

    @security_coordinator = SecurityCoordinator.new
  end

  def create
    @security_coordinator = SecurityCoordinator.new(params_security_coordinator)
    @security_coordinator.company = current_user.company
    authorize @security_coordinator
    if @security_coordinator.save
      # Create an ordered list to put the last one in first
      @security_coordinators = SecurityCoordinator.all.sort_by { |s| s.created_at }
      # Respond with the view security_coordinator/create.js.erb to close the modal and come back to the form
      respond_to do |format|
        format.js {}
      end
      # Useful for the infinite scroll, wh have to do it because we re-render the page after the action
      init_infinite_loop
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

  # Useful for the infinite loop
  def pagination
    if params[:query]
      @security_coordinators = policy_scope(SecurityCoordinator.search_security_coordinator(params[:query]))
    else
      @security_coordinators = policy_scope(SecurityCoordinator.all)
    end
    authorize @security_coordinators
    @security_coordinators_page = @security_coordinators.page(params[:page])
    render 'security_coordinators/_elements', collection: @security_coordinators_page, layout: false
  end

  private

  def init_infinite_loop
    # Useful for the infinite scroll
    @security_coordinators_page = Kaminari.paginate_array(@security_coordinators).page
    @endpoint = pagination_security_coordinators_path
    @page_amount = @security_coordinators_page.total_pages
  end

  def params_security_coordinator
    params.require(:security_coordinator).permit(:address, :name, :representative, :email, :phone, :company)
  end

  def find_security_coordinator
    @security_coordinator = SecurityCoordinator.find(params[:id])
  end
end
