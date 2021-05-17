class PpspsController < ApplicationController
  before_action :init_variables, only: %i[new create edit update]
  before_action :dropzone_annexes, only: %i[new create edit update]
  before_action :skip_authorization, only: :destroy_logo_client
  before_action :find_ppsp, only: %i[show ppsp_pdf destroy edit destroy_logo_client duplicate destroy_plan_installation]

  def index
    # Handled by react :) (app/assets/javascript/ppsp-react)
    # In order to search on direct
    users = User.where(company: current_user.company)
    @ppsps = policy_scope(Ppsp.where(user: users))
    # hospital_id is the last attribute which is mandatory
    @ppsps_on_working = Ppsp.where(user: current_user, hospital_id: nil)
  end

  def new
    @ppsp = Ppsp.new(user: current_user)
    authorize @ppsp
    # We save an instance of the ppsp in database even if not valid
    @ppsp.save!(validate: false)
    # We redirect to ppsp_step_path in order to begin the Wizard form
    redirect_to ppsp_step_path(@ppsp, Ppsp.form_steps.keys.first)
  end

  def show
    authorize @ppsp
    select_lifesaver = SelectedLifesaver.where(ppsp_id: @ppsp.id).pluck(:worker_id)
    @lifesavers = Worker.where(id: select_lifesaver)
    @conductors = Conductor.where(ppsp_id: @ppsp.id).order(:machine_id).group_by(&:machine_id)

    @marker = { lat: @ppsp.latitude, lng: @ppsp.longitude }

    # Numéro de suivi des titres de chaque partie
    @num_admin = 1
    @num_worksite = 1
    @num_security = 1
    @num_risk = 1

    handle_annexes
    respond_to do |format|
      # Two response for the show method depending on the format we call
      format.pdf do
        render(
          pdf: 'ppsp',
          enable_local_file_access: true,
          encoding: 'utf8',
          template: 'ppsps/show.pdf.erb',
          layout: 'pdf.html.erb',
          view_as_html: true,
          show_as_html: params.key?('debug'),
          # La couverture (cover) permet d'avoir une premiere page. Elle n'est pas incluse dans le layout, il faut tout intégrer "à la main" pour cette page.
          cover: render_to_string('ppsps/render_pages/cover.pdf.erb'),
          # Table of Content
          toc: {
            header_text: "Sommaire",
          },

          # Protect document
          basic_auth: true,  # when true username & password are automatically sent from session
          username: 'Obras',
          password: Rails.application.credentials.dig(:pdf, :password),

          margin: {
            top: 28, # default 10 (mm)
            bottom: 10
          },
          header: {
            html: {
              template: 'ppsps/render_pages/header.html.erb'
            },
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

  def edit
    authorize @ppsp
  end

  def destroy
    authorize @ppsp
    @ppsp.destroy
    redirect_to ppsps_path
  end

  def destroy_logo_client
    blob = ActiveStorage::Blob.find_by(key: params[:public_id])
    ActiveStorage::Attachment.find_by(blob: blob) ? ActiveStorage::Attachment.find_by(blob: blob).purge : blob.purge
    respond_to do |format|
      format.js { render 'ppsps/destroy_logo_client' }
    end
  end

  def destroy_annexe
    @ppsp = Ppsp.find(params[:ppsp_id])
    authorize @ppsp
    blob = ActiveStorage::Blob.find_by(key: params[:public_id])
    if ActiveStorage::Attachment.find_by(blob: blob)
      ActiveStorage::Attachment.find_by(blob: blob).purge
      respond_to do |format|
        format.js { render 'ppsps/destroy_annexe' }
      end
    else
      blob.purge if blob.present?
      head :no_content
    end
  end

  def destroy_plan_installation
    @ppsp.plan_installation.purge
    authorize @ppsp
    respond_to do |format|
      format.js { render 'worksites/destroy_plan' }
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

  def init_variables
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
  end

  def dropzone_annexes
    # To know how many annexes the user can download
    return @num_dropzone_annexes = 5 unless @ppsp
    @num_dropzone_annexes = @ppsp.annexes.attached? ? 5 - @ppsp.annexes.count : 5
  end

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
    params.require(:ppsp).permit(:moa_id, :moe_id, :security_coordinator_id,
                                 :regional_committee_id, :pension_insurance_id, :direcct_id, :work_medecine_id,
                                 :demining_id, :sos_hand_id, :anti_poison_id, :hospital_id, :logo_client, :content_secu, annexes: [],
                                                                                                                         worksite_attributes: %i[id address start_date end_date timetable_summer timetable_summer_start timetable_summer_end
                                                                                                                                                 timetable_summer_start_friday timetable_summer_end_friday
                                                                                                                                                 timetable_winter timetable_winter_start timetable_winter_end electrical_site
                                                                                                                                                 timetable_winter_start_friday timetable_winter_end_friday
                                                                                                                                                 water_site nature plan num_responsible num_conductor num_worker plan_installation
                                                                                                                                                 infirmary infirmary_text],
                                                                                                                         project_information_attributes: %i[id name reference responsible_id site_manager_id team_manager_id company_id])
  end
end
