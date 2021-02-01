class PpspsController < ApplicationController
  before_action :find_ppsp, only: %i[update show ppsp_pdf destroy edit destroy_logo_client]

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
    @subcontractor = Subcontractor.new

    # Select the databases present in the select lists
    @moas = policy_scope(Moa.all)
    @moes = policy_scope(Moe.all)
    @regional_committees = policy_scope(RegionalCommittee.all)
    @pension_insurances = policy_scope(PensionInsurance.all)
    @direccts = policy_scope(Direcct.all)
    @work_medecines = policy_scope(WorkMedecine.all)
    @deminings = policy_scope(Demining.all)
    @sos_hands = policy_scope(SosHand.all)
    @anti_poisons = policy_scope(AntiPoison.all)
    @hospitals = policy_scope(Hospital.all)
    @security_coordinators = policy_scope(SecurityCoordinator.all)
    @subcontractors = policy_scope(Subcontractor.all)

    ppsp_content_secu?
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
          # Display number of pages
          header: { right: '[page] of [topage]' },
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
    @subcontractor = Subcontractor.new
    @ppsp.user = current_user

    # Select the databases present in the select lists
    @moas = policy_scope(Moa.all)
    @moes = policy_scope(Moe.all)
    @regional_committees = policy_scope(RegionalCommittee.all)
    @pension_insurances = policy_scope(PensionInsurance.all)
    @direccts = policy_scope(Direcct.all)
    @work_medecines = policy_scope(WorkMedecine.all)
    @deminings = policy_scope(Demining.all)
    @sos_hands = policy_scope(SosHand.all)
    @anti_poisons = policy_scope(AntiPoison.all)
    @hospitals = policy_scope(Hospital.all)
    @security_coordinators = policy_scope(SecurityCoordinator.all)
    @subcontractors = policy_scope(Subcontractor.all)

    authorize @ppsp
    if @ppsp.save
      # Create the joint table if necessary
      create_selected_subcontractors
      create_selected_risks
      create_selected_site_installations
      create_selected_altitude_works

      redirect_to ppsp_path(@ppsp, format: :pdf)
    else
      flash.now.alert = "Le formulaire n'a pas été rempli correctement, merci de réessayer !"
      render :new
    end
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
    @subcontractor = Subcontractor.new

    # Select the databases present in the select lists
    @moas = policy_scope(Moa.all)
    @moes = policy_scope(Moe.all)
    @regional_committees = policy_scope(RegionalCommittee.all)
    @pension_insurances = policy_scope(PensionInsurance.all)
    @direccts = policy_scope(Direcct.all)
    @work_medecines = policy_scope(WorkMedecine.all)
    @deminings = policy_scope(Demining.all)
    @sos_hands = policy_scope(SosHand.all)
    @anti_poisons = policy_scope(AntiPoison.all)
    @hospitals = policy_scope(Hospital.all)
    @security_coordinators = policy_scope(SecurityCoordinator.all)
    # @subcontractors = policy_scope(Subcontractor.all)

    # Modifier la liste des sous-traitants affichés en fonction des sous-traitants déjà sélectionnés
    selected_subcontractors = SelectedSubcontractor.where(ppsp_id: params[:id])
    @subcontractors = Subcontractor.where.not(id: selected_subcontractors.map(&:subcontractor_id))

    ppsp_content_secu?
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
    @subcontractor = Subcontractor.new

    # Select the databases present in the select lists
    @moas = policy_scope(Moa.all)
    @moes = policy_scope(Moe.all)
    @regional_committees = policy_scope(RegionalCommittee.all)
    @pension_insurances = policy_scope(PensionInsurance.all)
    @direccts = policy_scope(Direcct.all)
    @work_medecines = policy_scope(WorkMedecine.all)
    @deminings = policy_scope(Demining.all)
    @sos_hands = policy_scope(SosHand.all)
    @anti_poisons = policy_scope(AntiPoison.all)
    @hospitals = policy_scope(Hospital.all)
    @security_coordinators = policy_scope(SecurityCoordinator.all)
    @subcontractors = policy_scope(Subcontractor.all)

    if @ppsp.update(params_ppsp)
      # Create the joint table if necessary
      create_selected_subcontractors
      create_selected_risks
      create_selected_site_installations
      create_selected_altitude_works

      redirect_to ppsp_path(@ppsp, format: :pdf)
    else
      render :edit
    end
  end

  def destroy_logo_client
    authorize @ppsp
    @ppsp.logo_client.purge
    respond_to do |format|
      format.js { render 'ppsps/destroy_logo_client' }
    end
  end

  private

  def create_selected_subcontractors
    if params.require(:ppsp).key?(:subcontractors)
      subcontractors = params.require(:ppsp).require(:subcontractors)
      subcontractors.each do |subcontractor_id|
        SelectedSubcontractor.create(ppsp_id: @ppsp.id, subcontractor_id: subcontractor_id)
      end
    end
  end

  def create_selected_risks
    if params.require(:ppsp).key?(:risks)
      risks = params.require(:ppsp).require(:risks)
      risks.shift
      risks.each do |risk_id|
        SelectedRisk.create(ppsp_id: @ppsp.id, risk_id: risk_id)
      end
    end
  end

  def create_selected_site_installations
    if params.require(:ppsp).key?(:site_installations)
      site_installations = params.require(:ppsp).require(:site_installations)
      site_installations.shift
      site_installations.each do |site_installation_id|
        SelectedInstallation.create(ppsp_id: @ppsp.id, site_installation_id: site_installation_id)
      end
    end
  end

  def create_selected_altitude_works
    if params.require(:ppsp).key?(:altitude_works)
      altitude_works = params.require(:ppsp).require(:altitude_works)
      altitude_works.shift
      altitude_works.each do |altitude_work_id|
        SelectedAltitude.create(ppsp_id: @ppsp.id, altitude_work_id: altitude_work_id)
      end
    end
  end

  def find_ppsp
    @ppsp = Ppsp.find(params[:id])
  end

  # Add in the dataset of the view a indicator which show if the PPSP already have a content_secu or not
  def ppsp_content_secu?
    @ppsp_content_secu = @ppsp.content_secu.present?
  end

  def params_ppsp
    params.require(:ppsp).permit(:address, :start_date, :end_date, :nature, :workforce, :agglomeration,
                                 :street_impact, :river_guidance, :moa_id, :moe_id, :security_coordinator_id,
                                 :regional_committee_id, :pension_insurance_id, :direcct_id, :work_medecine_id,
                                 :demining_id, :sos_hand_id, :anti_poison_id, :hospital_id, :logo_client, :content_secu,
                                 project_information_attributes: [:ppsp_id, :reference, :responsible,
                                                                  :phone, :email, { site_manager_attributes: %i[name email phone],
                                                                                    team_manager_attributes: %i[name
                                                                                                                email phone] }])
  end
end
