class PpspsController < ApplicationController
  before_action :find_ppsp, only: [ :update, :show, :ppsp_pdf, :destroy, :edit, :informations_supplementaires ]

  def index
    @ppsps = policy_scope(Ppsp.where(user: current_user))
  end

  def new
    @ppsp = Ppsp.new
    authorize @ppsp
  end

  def show
    authorize @ppsp
    # If you don't want to display in pdf anymore you can change the format in the index view
  end

  def ppsp_pdf
    respond_to do |format|
      format.html
      format.pdf do
        render pdf: 'ppsp', 
        encoding: 'utf8',
        template: "ppsps/show.pdf.erb",
        layout: "pdf.html.erb"
      end
    end
    authorize @ppsp
  end

  # def download_pdf
  #   pdf = WickedPdf.new.pdf_from_string(
  #   render_to_string('download_pdf', layout: false))
  #   send_data(pdf,
  #     filename: 'ppsp.pdf',
  #     type: 'application/pdf',
  #     disposition: 'attachment')
  # end

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
    @companies = Company.all
    # Input of the option of installations for the form
    @selected_installation = SelectedInstallation.new
    # Selected installations already existing for this PPSP
    @selected_installation_active = SelectedInstallation.where(ppsp_id: @ppsp.id)
    # Show all the work altitudes except "Autre" which will be entered within a string field by the user
    @work_altitudes = AltitudeWork.where.not(name: "Autre")
    # Input of the option of altitude work for the form
    @selected_altitude = SelectedAltitude.new
    # Selected altitude work already existing for this PPSP
    @selected_altitude_active = SelectedAltitude.where(ppsp_id: @ppsp.id)
    # Input of the option of altitude work for the form
    @selected_risk = SelectedRisk.new
    # Selected altitude work already existing for this PPSP
    @selected_risk_active = SelectedRisk.where(ppsp_id: @ppsp.id)
    # Input of the option of subcontractors for the form
    @subcontractor = Subcontractor.new
    # Selected subcontractors already existing for this PPSP
    @selected_subcontractor_active = SelectedSubcontractor.where(ppsp_id: @ppsp.id)
  end

  def edit
    authorize @ppsp
  end

  def update
    authorize @ppsp
    if @ppsp.update(params_ppsp)
      redirect_to informations_supplementaires_ppsp_path(@ppsp)
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
    params.require(:ppsp).permit(:address, :start, :end, :nature, :workforce, :agglomeration, 
    :street_impact, :river_guidance, :moa_id, :moe_id, :project_information_id, 
    :subcontractor_id, :regional_committee_id, :pension_insurance_id, :direcct_id, :work_medecine_id,
    :demining_id, :sos_hand_id, :anti_poison_id, :hospital_id)
  end

  def find_ppsp
    @ppsp = Ppsp.find(params[:id])
  end

end
