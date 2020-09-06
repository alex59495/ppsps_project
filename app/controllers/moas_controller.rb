class MoasController < ApplicationController
  before_action :find_moa, only: [ :update, :show, :destroy, :edit ]

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

  private
  def params_moa
    params.require(:moa).permit(:address, :name, :phone, :email, :representative)
  end

  def find_moa
    @moa = Moa.find(params[:id])
  end
end
