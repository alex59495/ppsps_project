class DirecctsController < ApplicationController
  before_action :find_direcct, only: [ :update, :show, :destroy, :edit ]


  def index
    @direccts = policy_scope(Direcct)
  end

  def new
    @direcct = Direcct.new
    authorize @direcct
  end

  def create
    @direcct = Direcct.new(params_direcct)
    authorize @direcct
    if @direcct.save
      redirect_to new_ppsp_path
    else
      render :new
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

  private
  def params_direcct
    params.require(:direcct).permit(:address, :phone, :fax)
  end

  def find_direcct
    @direcct = Direcct.find(params[:id])
  end
end
