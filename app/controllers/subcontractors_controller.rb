class SubcontractorsController < ApplicationController
  before_action :find_subcontractor, only: [ :update, :show, :destroy, :edit ]
  before_action :find_ppsp

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
      # Using the gem 'repost' to redirect with a post action to create the selected subcontractors element
      redirect_post ppsp_selected_subcontractors_path(subcontractor_id: @subcontractor.id), options: {authenticity_token: :auto}
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
    params.require(:subcontractor).permit(:address, :name, :work, 
    :responsible_name, :responsible_phone, :responsible_email)
  end

  def find_subcontractor
    @subcontractor = Subcontractor.find(params[:id])
  end

  def find_ppsp
    @ppsp = Ppsp.find(params[:ppsp_id])
  end
end
