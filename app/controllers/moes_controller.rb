class MoesController < ApplicationController
  before_action :find_moe, only: [ :update, :show, :destroyed, :edit ]

  def index
    authorize Moe
    if params[:query]
      sql_query = "name ILIKE :query OR address ILIKE :query OR phone ILIKE :query"
      @moes = policy_scope(Moe.where(sql_query, query: "%#{params[:query]}%", is_destroyed: false))
      # We are using form_with in the index view so it respond with ajax, to handle the response we have to activate a format response
      respond_to do |format|
        # Respond with the index.js.erb
        format.js {}
      end
    else
      @moes = policy_scope(Moe.where(is_destroyed: false))
      respond_to do |format|
        format.html {}
      end
    end
    @moe = Moe.new
  end

  def create
    @moe = Moe.new(params_moe)
    @moe.company = current_user.company
    authorize @moe
    if @moe.save
      # Create an ordered list to use in the view 'moe/_form_field_moe'
      @moes = Moe.all.sort_by { |moe| moe.name.downcase }
      # Respond with the view moe/create.js.erb to close the modal and come back to the form
      respond_to do |format|
        format.js {}
      end
    else
      # Respond with the .js.erb to print the modal with errors
      respond_to do |format|
        format.js { render 'ppsps/modal_moe' }
      end
    end
  end

  def edit
    authorize @moe
  end

  def update
    authorize @moe
    if @moe.update(params_moe)
      redirect_to moes_path
    else
      render :edit
    end
  end

  def destroyed
    authorize @moe
    @moe.is_destroyed = true
    if @moe.save
      redirect_to moes_path
    else
      flash.now[:error] = "L'élément n'a pas pu être supprimé"
    end
  end

  private
  def params_moe
    params.require(:moe).permit(:address, :name, :phone, :email, :representative, :company)
  end

  def find_moe
    @moe = Moe.find(params[:id])
  end
end
