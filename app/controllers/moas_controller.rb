class MoasController < ApplicationController
  def index
    @moas = policy_scope(Moa)
  end

  def new
    @moa = Moa.new
    authorize @moa
  end

  def create
    @moa = Moa.new(params_moa)
    authorize @moa
    if @moa.save
      redirect_to new_ppsp_path
    else
      render :new
    end
  end

  private
  def params_moa
    params.require(:moa).permit(:name, :address, :representative, :phone, :email)
  end
end
