class MoasController < ApplicationController
  before_action :find_moa, only: [ :update, :show, :destroyed, :edit ]

  def index
    authorize Moa
    if params[:query]
      sql_query = "name ILIKE :query OR address ILIKE :query OR phone ILIKE :query OR representative ILIKE :query OR email ILIKE :query"
      @moas = policy_scope(Moa.where(sql_query, query: "%#{params[:query]}%", is_destroyed: false))
      # We are using form_with in the index view so it respond with ajax, to handle the response we have to activate a format response
      respond_to do |format|
        # Respond with the index.js.erb
        format.js {}
      end
    else
      @moas = policy_scope(Moa.where(is_destroyed: false))
      respond_to do |format|
        format.html {}
      end
    end
    @moa = Moa.new
  end

  def create
    @moa = Moa.new(params_moa)
    @moa.company = current_user.company
    authorize @moa
    if @moa.save
      # Create an ordered list to use in the view 'moa/_form_field_moa'
      @moas = Moa.all.sort_by { |moa| moa.name }
      # Respond with the view moa/create.js.erb to close the modal and come back to the form
      respond_to do |format|
        format.js {}
      end
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

  private
  def params_moa
    params.require(:moa).permit(:address, :name, :phone, :email, :representative, :company)
  end

  def find_moa
    @moa = Moa.find(params[:id])
  end
end
