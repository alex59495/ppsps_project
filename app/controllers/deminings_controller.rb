class DeminingsController < ApplicationController
  before_action :find_demining, only: [ :update, :show, :destroyed, :edit ]

  def index
    authorize Demining
    if params[:query]
      @deminings = policy_scope(Demining.search_demining(params[:query]))
      @search = 'search'
      # We are using form_with in the index view so it respond with ajax, to handle the response we have to activate a format response
      respond_to do |format|
        # Respond with the index.js.erb
        format.js {}
      end
    else
      @deminings = policy_scope(Demining.all)
      @search = 'none'
      # Must be able to respond in HTML (when load the page) and JS (when click on button Show all databse)
      respond_to do |format|
        format.html {}
        format.js {}
      end
    end

    init_infinite_loop

    @demining = Demining.new
  end

  def create
    @demining = Demining.new(params_demining)
    @demining.company = current_user.company
    authorize @demining
    if @demining.save
      # Create an ordered list to put the last one in first
      @deminings = Demining.all.sort_by { |demining| demining.created_at }
      # Respond with the view demining/create.js.erb to close the modal and come back to the form
      respond_to do |format|
        format.js {}
      end
      # Useful for the infinite scroll, wh have to do it because we re-render the page after the action
      init_infinite_loop
    else
      # Respond with the .js.erb to print the modal with errors
      respond_to do |format|
        format.js { render 'ppsps/modal_demining' }
      end
    end
  end

  def edit
    authorize @demining
  end

  def update
    authorize @demining
    if @demining.update(params_demining)
      redirect_to deminings_path
    else
      render :edit
    end
  end

  def destroyed
    authorize @demining
    @demining.is_destroyed = true
    if @demining.save
      redirect_to deminings_path
    else
      flash.now[:error] = "L'élément n'a pas pu être supprimé"
    end
  end

  # Useful for the infinite loop
  def pagination
    if params[:query]
      @deminings = policy_scope(Demining.search_demining(params[:query]))
    else
      @deminings = policy_scope(Demining.all)
    end
    authorize @deminings
    @deminings_page = @deminings.page(params[:page])
    render 'deminings/_elements', collection: @deminings_page, layout: false
  end

  private

  def init_infinite_loop
    # Useful for the infinite scroll
    @deminings_page = Kaminari.paginate_array(@deminings).page
    @endpoint = pagination_deminings_path
    @page_amount = @deminings_page.total_pages
  end

  def params_demining
    params.require(:demining).permit(:address, :name, :phone, :company)
  end

  def find_demining
    @demining = Demining.find(params[:id])
  end
end
