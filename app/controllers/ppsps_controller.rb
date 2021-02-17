class PpspsController < ApplicationController
  before_action :find_ppsp, only: %i[update show ppsp_pdf destroy edit destroy_logo_client duplicate destroy_annexe]

  def index
    # Handled by react :) (app/assets/javascript/ppsp-react)
    # In order to search on direct
    users = User.where(company: current_user.company)
    @ppsps = policy_scope(Ppsp.where(user: users))
  end

  def new
    @ppsp = Ppsp.new
    authorize @ppsp
    # Create the fields for the project_information,
    # We used the 'accepts_nested_attributes_for' in the models
    # We used the projection_information_attributes in the params
    @project_information = @ppsp.build_project_information

    @worksite = @ppsp.build_worksite

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
    select_lifesaver = SelectedLifesaver.where(ppsp_id: @ppsp.id).pluck(:worker_id)
    @lifesavers = Worker.where(id: select_lifesaver)
    @conductors = Conductor.where(ppsp_id: @ppsp.id).order(:machine_id).group_by(&:machine_id)

    @marker = { lat: @ppsp.worksite.latitude, lng: @ppsp.worksite.longitude }

    # Numéro de suivi des titres de chaque partie
    @num_admin = 1
    @num_worksite = 1
    @num_security = 1
    @num_risk = 1

    handle_annexes
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
          view_as_html: true,
          # La couverture (cover) permet d'avoir une premiere page. Elle n'est pas incluse dans le layout, il faut tout intégrer "à la main" pour cette page.
          cover: render_to_string('ppsps/render_pages/cover.pdf.erb'),
          # Table of Content
          toc: {
            header_text: "Sommaire"
          },
          margin: {
            top: 28, # default 10 (mm)
            bottom: 10
          },
          header: {
            html: {
              template: 'ppsps/render_pages/header.html.erb'
            }
          },
          footer: {
            # Display number of pages
            # right: '[page] of [topage]',
            html: {
              template: 'ppsps/render_pages/footer.html.erb'
            }
          }
        )
      end
    end
  end

  def create
    @ppsp = Ppsp.new(params_ppsp)
    @ppsp.project_information.company = current_user.company
    @ppsp.user = current_user
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

    authorize @ppsp
    if @ppsp.save
      # Create the joint table if necessary
      create_selected_subcontractors
      create_selected_risks
      create_selected_site_installations
      create_selected_altitude_works
      create_selected_conductors
      create_selected_lifesavers
      purge_plan_installation_if_not_selected

      redirect_to ppsp_path(@ppsp, format: :pdf)
    else
      render :new
      flash.now.alert = "Le formulaire n'a pas été rempli correctement, merci de réessayer"
    end
  end

  def edit
    authorize @ppsp
    # This way the edit page is able to retrieve the project informations and worksite
    @project_information = @ppsp.project_information
    @worksite = @ppsp.worksite
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

    ppsp_content_secu?
  end

  def update
    authorize @ppsp
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

    # We have to redefine the ID because if we don't nested form of rails will create a new instance of worksite and project info
    if @ppsp.update(params_ppsp)
      # Create the joint table if necessary
      create_selected_subcontractors
      create_selected_risks
      create_selected_site_installations
      create_selected_altitude_works
      create_selected_conductors
      create_selected_lifesavers
      purge_plan_installation_if_not_selected

      redirect_to ppsp_path(@ppsp, format: :pdf)
    else
      flash.now.alert = "Le formulaire n'a pas été rempli correctement, merci de réessayer"
      render :edit
    end
  end

  def destroy_logo_client
    authorize @ppsp
    @purge = true if @ppsp.logo_client.purge
    respond_to do |format|
      format.js { render 'ppsps/destroy_logo_client' }
    end
  end

  def destroy_annexe
    authorize @ppsp
    blob = ActiveStorage::Blob.find_by(key: params[:public_id])
    ActiveStorage::Attachment.find_by(blob: blob).purge
    respond_to do |format|
      format.js { render 'ppsps/destroy_annexe' }
    end
  end

  def duplicate
    @ppsp_duplicate = @ppsp.dup
    authorize @ppsp_duplicate
    @ppsp_duplicate.user = current_user
    @ppsp_duplicate.save
    redirect_to edit_ppsp_path(@ppsp_duplicate)
  end

  private

  # On regarde quels sont les Tables jointes des conducteurs (associé au current_user) qui n'ont pas encore de PPSP
  # et on leur associe le PPSP qui vient d'être créé
  def create_selected_conductors
    @conductors = policy_scope(Conductor.all.where(ppsp_id: nil))
    @conductors.each do |conductor|
      conductor.ppsp = @ppsp
      conductor.save!
    end
  end

  def create_selected_lifesavers
    if params.require(:ppsp).key?(:lifesavers)
      lifesavers = params.require(:ppsp).require(:lifesavers)
      lifesavers.shift
      lifesavers.each do |lifesaver_id|
        SelectedLifesaver.create!(ppsp_id: @ppsp.id, worker_id: lifesaver_id)
      end
    end
  end

  def create_selected_subcontractors
    if params.require(:ppsp).key?(:subcontractors)
      subcontractors = params.require(:ppsp).require(:subcontractors)
      subcontractors.shift
      subcontractors.each do |subcontractor_id|
        SelectedSubcontractor.create!(ppsp_id: @ppsp.id, subcontractor_id: subcontractor_id)
      end
    end
  end

  def create_selected_risks
    if params.require(:ppsp).key?(:risks)
      risks = params.require(:ppsp).require(:risks)
      risks.shift
      risks.each do |risk_id|
        SelectedRisk.create!(ppsp_id: @ppsp.id, risk_id: risk_id)
      end
    end
  end

  def create_selected_site_installations
    if params.require(:ppsp).key?(:site_installations)
      site_installations = params.require(:ppsp).require(:site_installations)
      site_installations.shift
      site_installations.each do |site_installation_id|
        SelectedInstallation.create!(ppsp_id: @ppsp.id, site_installation_id: site_installation_id)
      end
    end
  end

  def create_selected_altitude_works
    if params.require(:ppsp).key?(:altitude_works)
      altitude_works = params.require(:ppsp).require(:altitude_works)
      altitude_works.shift
      altitude_works.each do |altitude_work_id|
        SelectedAltitude.create!(ppsp_id: @ppsp.id, altitude_work_id: altitude_work_id)
      end
    end
  end

  def purge_plan_installation_if_not_selected
    @ppsp.worksite.plan_installation.purge if !@ppsp.worksite.plan && @ppsp.worksite.plan_installation.attached?
  end

  def find_ppsp
    @ppsp = Ppsp.find(params[:id])
  end

  # Add in the dataset of the view a indicator which show if the PPSP already have a content_secu or not
  def ppsp_content_secu?
    @ppsp_content_secu = @ppsp.content_secu.present?
  end

  def handle_annexes
    return unless @ppsp.annexes.attached?

    @annexes = {}
    @ppsp.annexes.each_with_index do |annexe, index|
      @annexes[index] = {
        pages: Cloudinary::Api.resource(annexe.key, pages: true)["pages"],
        key: annexe.key
      }
    end
  end

  def params_ppsp
    params.require(:ppsp).permit(:agglomeration, :river_guidance, :moa_id, :moe_id, :security_coordinator_id,
                                 :street_impact, :regional_committee_id, :pension_insurance_id, :direcct_id, :work_medecine_id,
                                 :demining_id, :sos_hand_id, :anti_poison_id, :hospital_id, :logo_client, :content_secu, annexes: [],
                                                                                                                         worksite_attributes: %i[id address start_date end_date timetable_summer timetable_summer_start timetable_summer_end
                                                                                                                                                 timetable_winter timetable_winter_start timetable_winter_end electrical_site
                                                                                                                                                 water_site nature plan num_responsible num_conductor num_worker plan_installation],
                                                                                                                         project_information_attributes: %i[id name reference responsible_id site_manager_id team_manager_id company_id])
  end
end
