class MoesController < ApplicationController
  def new
    @moe = Moe.new
    authorize @moe
  end

  def create
    @moe = Moe.new(params_moe)
    authorize @moe
    if @moe.save
      redirect_to new_ppsp_path
    else
      render :new
    end
  end

  private
  def params_moe
    params.require(:moe).permit(:name, :address, :representative, :phone, :email)
  end
end
