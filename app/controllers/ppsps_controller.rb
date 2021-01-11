class PpspsController < ApplicationController
  before_action :find_ppsp, only: %i[update show ppsp_pdf destroy edit informations_supplementaires]

  def index
    # Handled by react :) (app/assets/javascript/ppsp-react)
    # In order to search on direct
    users = User.where(company: current_user.company)
    @ppsps = policy_scope(Ppsp.where(user: users))
  end

  def new
    @ppsp = Ppsp.new
    authorize @ppsp
    # Create the fields for the project_information, site_manager and team_manager => Nested form in the view
    # This way they are created in the DB if the @ppsp is saved
    # We used the 'accepts_nested_attributes_for' in the models
    # We used the projection_information_attributes in the params
    @project_information = @ppsp.build_project_information
    @site_manager = @ppsp.build_project_information.build_site_manager
    @team_manager = @ppsp.build_project_information.build_team_manager

    # Info to add the possibility to create a new element through a modal form
    @project_information = ProjectInformation.new
    @security_coordinator = SecurityCoordinator.new
    @hospital = Hospital.new
    @moa = Moa.new
    @moe = Moe.new
    @pension_insurance = PensionInsurance.new
    @regional_committee = RegionalCommittee.new
    @direcct = Direcct.new
    @work_medecine = WorkMedecine.new
    @demining = Demining.new
    @sos_hand = SosHand.new
    @anti_poison = AntiPoison.new

    # Select the databases present in the select lists
    @moas = Moa.where(company: current_user.company, is_destroyed: false)
    @moes = Moe.where(company: current_user.company, is_destroyed: false)
    @regional_committees = RegionalCommittee.where(company: current_user.company, is_destroyed: false)
    @pension_insurances = PensionInsurance.where(company: current_user.company, is_destroyed: false)
    @direccts = Direcct.where(company: current_user.company, is_destroyed: false)
    @work_medecines = WorkMedecine.where(company: current_user.company, is_destroyed: false)
    @deminings = Demining.where(company: current_user.company, is_destroyed: false)
    @sos_hands = SosHand.where(company: current_user.company, is_destroyed: false)
    @anti_poisons = AntiPoison.where(company: current_user.company, is_destroyed: false)
    @hospitals = Hospital.where(company: current_user.company, is_destroyed: false)
    @security_coordinators = SecurityCoordinator.where(company: current_user.company, is_destroyed: false)
  end

  def show
    authorize @ppsp
    @n = 0
    respond_to do |format|
      # Two response for the show method depending on the format we call
      format.html
      format.pdf do
        render(
          pdf: 'ppsp',
          enable_local_file_access: true,
          encoding: 'utf8',
          template: 'ppsps/show.pdf.erb',
          layout: 'pdf.html.erb',
          footer: {
            html: {
              template: 'ppsps/footer.html.erb'
            }
          }
        )
      end
    end
  end

  def create
    @ppsp = Ppsp.new(params_ppsp)
    # Info to add the possibility to create a new element through a modal form
    @security_coordinator = SecurityCoordinator.new
    @hospital = Hospital.new
    @moa = Moa.new
    @moe = Moe.new
    @pension_insurance = PensionInsurance.new
    @regional_committee = RegionalCommittee.new
    @direcct = Direcct.new
    @work_medecine = WorkMedecine.new
    @demining = Demining.new
    @sos_hand = SosHand.new
    @anti_poison = AntiPoison.new
    @ppsp.user = current_user

    # Select the databases present in the select lists
    @moas = Moa.where(company: current_user.company, is_destroyed: false)
    @moes = Moe.where(company: current_user.company, is_destroyed: false)
    @regional_committees = RegionalCommittee.where(company: current_user.company, is_destroyed: false)
    @pension_insurances = PensionInsurance.where(company: current_user.company, is_destroyed: false)
    @direccts = Direcct.where(company: current_user.company, is_destroyed: false)
    @work_medecines = WorkMedecine.where(company: current_user.company, is_destroyed: false)
    @deminings = Demining.where(company: current_user.company, is_destroyed: false)
    @sos_hands = SosHand.where(company: current_user.company, is_destroyed: false)
    @anti_poisons = AntiPoison.where(company: current_user.company, is_destroyed: false)
    @hospitals = Hospital.where(company: current_user.company, is_destroyed: false)
    @security_coordinators = SecurityCoordinator.where(company: current_user.company, is_destroyed: false)

    authorize @ppsp
    if @ppsp.save
      redirect_to informations_supplementaires_ppsp_path(@ppsp)
    else
      flash.now.alert = "Le formulaire n'a pas été rempli correctement, merci de réessayer !"
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
    @num_info_select = @selected_installation_active.count + @selected_altitude_active.count + @selected_risk_active.count + @ppsp.subcontractors.count
  end

  def edit
    authorize @ppsp
    # This way the edit page is able to retrieve the project informations
    @project_information = @ppsp.project_information
    @site_manager = @ppsp.project_information.site_manager
    @team_manager = @ppsp.project_information.team_manager

    # Info to add the possibility to create a new element through a modal form!
    @security_coordinator = SecurityCoordinator.new
    @hospital = Hospital.new
    @moa = Moa.new
    @moe = Moe.new
    @pension_insurance = PensionInsurance.new
    @regional_committee = RegionalCommittee.new
    @direcct = Direcct.new
    @work_medecine = WorkMedecine.new
    @demining = Demining.new
    @sos_hand = SosHand.new
    @anti_poison = AntiPoison.new

    # Select the databases present in the select lists
    @moas = Moa.where(company: current_user.company, is_destroyed: false)
    @moes = Moe.where(company: current_user.company, is_destroyed: false)
    @regional_committees = RegionalCommittee.where(company: current_user.company, is_destroyed: false)
    @pension_insurances = PensionInsurance.where(company: current_user.company, is_destroyed: false)
    @direccts = Direcct.where(company: current_user.company, is_destroyed: false)
    @work_medecines = WorkMedecine.where(company: current_user.company, is_destroyed: false)
    @deminings = Demining.where(company: current_user.company, is_destroyed: false)
    @sos_hands = SosHand.where(company: current_user.company, is_destroyed: false)
    @anti_poisons = AntiPoison.where(company: current_user.company, is_destroyed: false)
    @hospitals = Hospital.where(company: current_user.company, is_destroyed: false)
    @security_coordinators = SecurityCoordinator.where(company: current_user.company, is_destroyed: false)
  end

  def update
    authorize @ppsp
    # This way the update is able to retrieve the project informations
    @project_information = @ppsp.project_information
    @site_manager = @ppsp.project_information.site_manager
    @team_manager = @ppsp.project_information.team_manager

    # Info to add the possibility to create a new element through a modal form
    @security_coordinator = SecurityCoordinator.new
    @hospital = Hospital.new
    @moa = Moa.new
    @moe = Moe.new
    @pension_insurance = PensionInsurance.new
    @regional_committee = RegionalCommittee.new
    @direcct = Direcct.new
    @work_medecine = WorkMedecine.new
    @demining = Demining.new
    @sos_hand = SosHand.new
    @anti_poison = AntiPoison.new

    # Select the databases present in the select lists
    @moas = Moa.where(company: current_user.company, is_destroyed: false)
    @moes = Moe.where(company: current_user.company, is_destroyed: false)
    @regional_committees = RegionalCommittee.where(company: current_user.company, is_destroyed: false)
    @pension_insurances = PensionInsurance.where(company: current_user.company, is_destroyed: false)
    @direccts = Direcct.where(company: current_user.company, is_destroyed: false)
    @work_medecines = WorkMedecine.where(company: current_user.company, is_destroyed: false)
    @deminings = Demining.where(company: current_user.company, is_destroyed: false)
    @sos_hands = SosHand.where(company: current_user.company, is_destroyed: false)
    @anti_poisons = AntiPoison.where(company: current_user.company, is_destroyed: false)
    @hospitals = Hospital.where(company: current_user.company, is_destroyed: false)
    @security_coordinators = SecurityCoordinator.where(company: current_user.company, is_destroyed: false)

    if @ppsp.update(params_ppsp)
      redirect_to informations_supplementaires_ppsp_path(@ppsp)
    else
      render :edit
    end
  end

  private

  def params_ppsp
    params.require(:ppsp).permit(:address, :start_date, :end_date, :nature, :workforce, :agglomeration,
                                 :street_impact, :river_guidance, :moa_id, :moe_id, :subcontractor_ids, :security_coordinator_id,
                                 :regional_committee_id, :pension_insurance_id, :direcct_id, :work_medecine_id,
                                 :demining_id, :sos_hand_id, :anti_poison_id, :hospital_id,
                                 project_information_attributes: [:ppsp_id, :reference, :responsible,
                                                                  :phone, :email, { site_manager_attributes: %i[name email phone],
                                                                                    team_manager_attributes: %i[name
                                                                                                                email phone] }])
  end

  def find_ppsp
    @ppsp = Ppsp.find(params[:id])
  end
end
