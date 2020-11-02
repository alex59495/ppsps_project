class AntiPoisonsController < ApplicationController
  before_action :find_anti_poison, only: [ :update, :show, :destroy, :edit ]

  def index
    @anti_poisons = policy_scope(AntiPoison)
    @anti_poison = AntiPoison.new
  end

  def show
    authorize @anti_poison
  end

  def new
    @anti_poison = AntiPoison.new
    authorize @anti_poison
  end

  def create
    @anti_poison = AntiPoison.new(params_anti_poison)
    authorize @anti_poison
    if @anti_poison.save
      # Create an ordered list to use in the view 'anti_poison/_form_field_anti_poison'
      @anti_poisons = AntiPoison.all.sort_by { |anti_poison| anti_poison.name }
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

  private
  def params_anti_poison
    params.require(:anti_poison).permit(:address, :name, :phone)
  end

  def find_anti_poison
    @anti_poison = AntiPoison.find(params[:id])
  end
end
