class AntiPoisonsController < ApplicationController
  before_action :find_anti_poison, only: [ :update, :show, :destroyed, :edit ]

  def index
    authorize AntiPoison
    if params[:query]
      @anti_poisons = policy_scope(AntiPoison.search_anti_poison(params[:query]))
      @search = 'search'
      # We are using form_with in the index view so it respond with ajax, to handle the response we have to activate a format response
      respond_to do |format|
        # Respond with the index.js.erb
        format.js {}
      end
    else
      @anti_poisons = policy_scope(AntiPoison.all)
      @search = 'none'
      # Must be able to respond in HTML (when load the page) and JS (when click on button Show all databse)
      respond_to do |format|
        format.html {}
        format.js {}
      end
    end
    # Useful for the infinite scroll
    init_infinite_loop
    @anti_poison = AntiPoison.new
  end

  def create
    @anti_poison = AntiPoison.new(params_anti_poison)
    @anti_poison.company = current_user.company
    authorize @anti_poison
    if @anti_poison.save
      # Create an ordered list to put the last one in first
      @anti_poisons = policy_scope(AntiPoison.all).sort_by { |anti_poison| anti_poison.created_at }
      # Useful for the infinite scroll, wh have to do it because we re-render the page after the action
      init_infinite_loop
      # Respond with the view anti_poison/create.js.erb to close the modal and come back to the form
      respond_to do |format|
        format.js {}
      end
    else
      # Respond with the .js.erb to print the modal with errors
      respond_to do |format|
        format.js { render 'ppsps/modal_anti_poison' }
      end
    end

  end

  def edit
    authorize @anti_poison
  end

  def update
    authorize @anti_poison
    if @anti_poison.update(params_anti_poison)
      redirect_to anti_poisons_path
    else
      render :edit
    end
  end

  def destroyed
    authorize @anti_poison
    @anti_poison.is_destroyed = true
    if @anti_poison.save
      redirect_to anti_poisons_path
    else
      flash.now[:error] = "L'élément n'a pas pu être supprimé"
    end
  end

  # Useful for the infinite loop
  def pagination
    if params[:query]
      @anti_poisons = policy_scope(AntiPoison.search_anti_poison(params[:query]))
    else
      @anti_poisons = policy_scope(AntiPoison.all)
    end
    authorize @anti_poisons
    @anti_poisons_page = @anti_poisons.page(params[:page])
    render 'anti_poisons/_elements', collection: @anti_poisons_page, layout: false
  end

  private

  def init_infinite_loop
    # Useful for the infinite scroll
    @anti_poisons_page = Kaminari.paginate_array(@anti_poisons).page
    @endpoint = pagination_anti_poisons_path
    @page_amount = @anti_poisons_page.total_pages
  end

  def params_anti_poison
    params.require(:anti_poison).permit(:address, :name, :phone, :company)
  end

  def find_anti_poison
    @anti_poison = AntiPoison.find(params[:id])
  end
end
