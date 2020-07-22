class PpspsController < ApplicationController
  before_action :find_ppsp, only: [ :update, :show, :destroy, :edit, :informations_supplementaires ]

  def index
    @ppsps = policy_scope(Ppsp.where(user: current_user))
  end

  def new
    @ppsp = Ppsp.new
    authorize @ppsp
    @companies = Company.all
  end

  def show
    authorize @ppsp
  end

  def create
    @ppsp = Ppsp.new(params_ppsp)
    @ppsp.user = current_user
    authorize @ppsp
    if @ppsp.save
      redirect_to informations_supplementaires_ppsp_path(@ppsp)
    else
      render :new
    end
  end

  def informations_supplementaires
    authorize @ppsp
    # Needed in the form
    @selected_installation = SelectedInstallation.new
    # Selected installations already existing for this PPSP
    @selected_active = SelectedInstallation.where(ppsp_id: @ppsp.id)
  end

  def edit
    authorize @ppsp
  end

  def update
    authorize @ppsp
    if @ppsp.update(params_ppsp)
      redirect_to ppsps_path
    else
      render :edit
    end
  end

  def destroy
    authorize @ppsp
    @ppsp.destroy
    redirect_to ppsps_path
  end

  private
  def params_ppsp
    params.require(:ppsp).permit(:address, :start, :end, :nature, :workforce, :agglomeration, :street_impact, :river_guidance, :company_id, :moa_id, :moe_id, :project_information_id)
  end

  def find_ppsp
    @ppsp = Ppsp.find(params[:id])
  end

end
