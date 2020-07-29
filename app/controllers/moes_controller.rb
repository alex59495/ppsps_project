class MoesController < ApplicationController
  before_action :find_moe, only: [ :update, :show, :destroy, :edit ]

  def index
    @moes = policy_scope(Moe)
  end

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

  private
  def params_moe
    params.require(:moe).permit(:address, :name, :phone, :email, :representative)
  end

  def find_moe
    @moe = Moe.find(params[:id])
  end
end
