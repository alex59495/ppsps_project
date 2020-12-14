class MoasController < ApplicationController
  before_action :find_moa, only: [ :update, :show, :destroyed, :edit ]

  def index
    authorize Moa
    if params[:query]
      @moas = policy_scope(Moa.search_moa(params[:query]))
      # We are using form_with in the index view so it respond with ajax, to handle the response we have to activate a format response
      respond_to do |format|
        # Respond with the index.js.erb
        format.js {}
      end
    else
      @moas = policy_scope(Moa.all)
      # Must be able to respond in HTML (when load the page) and JS (when click on button Show all databse)
      respond_to do |format|
        format.html {}
        format.js {}
      end
    end

   init_infinite_loop

    @moa = Moa.new
  end

  def create
    @moa = Moa.new(params_moa)
    @moa.company = current_user.company
    authorize @moa
    if @moa.save
      # Create an ordered list to put the last one in first
      @moas = Moa.all.sort_by { |moa| moa.created_at }
      # Respond with the view moa/create.js.erb to close the modal and come back to the form
      respond_to do |format|
        format.js {}
      end
      # Useful for the infinite scroll, wh have to do it because we re-render the page after the action
      init_infinite_loop
    else
      # Respond with the .js.erb to print the modal with errors
      respond_to do |format|
        format.js { render 'ppsps/modal_moa' }
      end
    end
  end

  def edit
    authorize @moa
  end

  def update
    authorize @moa
    if @moa.update(params_moa)
      redirect_to moas_path
    else
      render :edit
    end
  end

  def destroyed
    authorize @moa
    @moa.is_destroyed = true
    if @moa.save
      redirect_to moas_path
    else
      flash.now[:error] = "L'élément n'a pas pu être supprimé"
    end
  end

  # Useful for the infinite loop
  def pagination
    if params[:query]
      @moas = policy_scope(Moa.search_moa(params[:query]))
    else
      @moas = policy_scope(Moa.all)
    end
    authorize @moas
    @moas_page = @moas.page(params[:page])
    render 'moas/_element', collection: @moas_page, layout: false
  end

  private

  def init_infinite_loop
     # Useful for the infinite scroll
     @moas_page = Kaminari.paginate_array(@moas).page
     @endpoint = pagination_moas_path
     @page_amount = @moas_page.total_pages
  end

  def params_moa
    params.require(:moa).permit(:address, :name, :phone, :email, :representative, :company)
  end

  def find_moa
    @moa = Moa.find(params[:id])
  end
end
