class AntiPoisonsController < ApplicationController
  before_action :find_anti_poison, only: [ :update, :show, :destroy, :edit ]

  def index
    @anti_poisons = policy_scope(AntiPoison)
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
      redirect_to new_ppsp_path
    else
      render :new
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
