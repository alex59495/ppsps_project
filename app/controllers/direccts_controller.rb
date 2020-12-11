class DirecctsController < ApplicationController
  before_action :find_direcct, only: [ :update, :show, :destroyed, :edit ]

  def index
    authorize Direcct
    if params[:query]
      @direccts = policy_scope(Direcct.search_direcct(params[:query]))
      # We are using form_with in the index view so it respond with ajax, to handle the response we have to activate a format response
      respond_to do |format|
        # Respond with the index.js.erb
        format.js {}
      end
    else
      @direccts = policy_scope(Direcct.all)
      # Must be able to respond in HTML (when load the page) and JS (when click on button Show all databse)
      respond_to do |format|
        format.html {}
        format.js {}
      end
    end
    @direcct = Direcct.new
  end

  def create
    @direcct = Direcct.new(params_direcct)
    @direcct.company = current_user.company
    authorize @direcct
    if @direcct.save
      # Create an ordered list to use in the view 'direcct/_form_field_direcct'
      @direccts = Direcct.all.sort_by { |direcct| direcct.address }
      # Respond with the view direcct/create.js.erb to close the modal and come back to the form
      respond_to do |format|
        format.js {}
      end
    else
      # Respond with the .js.erb to print the modal with errors
      respond_to do |format|
        format.js { render 'ppsps/modal_direcct' }
      end
    end
  end

  def edit
    authorize @direcct
  end

  def update
    authorize @direcct
    if @direcct.update(params_direcct)
      redirect_to direccts_path
    else
      render :edit
    end
  end

  def destroyed
    authorize @direcct
    @direcct.is_destroyed = true
    if @direcct.save
      redirect_to direccts_path
    else
      flash.now[:error] = "L'élément n'a pas pu être supprimé"
    end
  end

  private
  def params_direcct
    params.require(:direcct).permit(:address, :phone, :fax, :company)
  end

  def find_direcct
    @direcct = Direcct.find(params[:id])
  end
end
