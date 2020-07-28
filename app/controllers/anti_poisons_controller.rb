class AntiPoisonsController < ApplicationController
  def index
    @anti_poisons = policy_scope(AntiPoison)
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

  private
  def params_anti_poison
    params.require(:anti_poison).permit(:address, :name, :phone)
  end
end
