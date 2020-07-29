class SubcontractorsController < ApplicationController
  before_action :find_subcontractor, only: [ :update, :show, :destroy, :edit ]

  def index
    @subcontractors = policy_scope(Subcontractor)
  end

  def new
    @subcontractor = Subcontractor.new
    authorize @subcontractor
  end

  def create
    @subcontractor = Subcontractor.new(params_subcontractor)
    authorize @subcontractor
    if @subcontractor.save
      redirect_to new_ppsp_path
    else
      render :new
    end
  end

  def edit
    authorize @subcontractor
  end

  def update
    authorize @subcontractor
    if @subcontractor.update(params_subcontractor)
      redirect_to subcontractors_path
    else
      render :edit
    end
  end

  private
  def params_subcontractor
    params.require(:subcontractor).permit(:address, :name, :work, :id_sub_responsible)
  end

  def find_subcontractor
    @subcontractor = Subcontractor.find(params[:id])
  end
end
