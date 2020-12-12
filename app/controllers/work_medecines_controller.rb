class WorkMedecinesController < ApplicationController
  before_action :find_work_medecine, only: [ :update, :show, :destroyed, :edit ]

  def index
    authorize WorkMedecine
    if params[:query]
      @work_medecines = policy_scope(WorkMedecine.search_work_medecine(params[:query]))
      # We are using form_with in the index view so it respond with ajax, to handle the response we have to activate a format response
      respond_to do |format|
        # Respond with the index.js.erb
        format.js {}
      end
    else
      @work_medecines = policy_scope(WorkMedecine.all)
      # Must be able to respond in HTML (when load the page) and JS (when click on button Show all databse)
      respond_to do |format|
        format.html {}
        format.js {}
      end
    end
    @work_medecine = WorkMedecine.new

    # Useful for the infinite scroll
    @work_medecines_page = @work_medecines.page
    @endpoint = pagination_work_medecines_path
    @page_amount = @work_medecines_page.total_pages

  end

  def create
    @work_medecine = WorkMedecine.new(params_work_medecine)
    @work_medecine.company = current_user.company
    authorize @work_medecine
    if @work_medecine.save
      # Create an ordered list to use in the view 'work_medecine/_form_field_work_medecine'
      @work_medecines = WorkMedecine.all.sort_by { |work_medecine| work_medecine.address }
      # Respond with the view work_medecine/create.js.erb to close the modal and come back to the form
      respond_to do |format|
        format.js {}
      end
    else
      # Respond with the .js.erb to print the modal with errors
      respond_to do |format|
        format.js { render 'ppsps/modal_work_medecine' }
      end
    end
  end

  def edit
    authorize @work_medecine
  end

  def update
    authorize @work_medecine
    if @work_medecine.update(params_work_medecine)
      redirect_to work_medecines_path
    else
      render :edit
    end
  end

  def destroyed
    authorize @work_medecine
    @work_medecine.is_destroyed = true
    if @work_medecine.save
      redirect_to work_medecines_path
    else
      flash.now[:error] = "L'élément n'a pas pu être supprimé"
    end
  end

  # Useful for the infinite loop
  def pagination
    if params[:query]
      @work_medecines = policy_scope(WorkMedecine.search_work_medecine(params[:query]))
    else
      @work_medecines = policy_scope(WorkMedecine.all)
    end
    authorize @work_medecines
    @work_medecines_page = @work_medecines.page(params[:page])
    render 'work_medecines/_element', collection: @work_medecines_page, layout: false
  end

  private
  def params_work_medecine
    params.require(:work_medecine).permit(:address, :fax, :phone, :company)
  end

  def find_work_medecine
    @work_medecine = WorkMedecine.find(params[:id])
  end
end
