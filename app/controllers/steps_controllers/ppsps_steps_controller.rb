module StepsControllers
  class PpspsStepsController < ApplicationController
    include Wicked::Wizard

    before_action :set_ppsp, only: %i[show update wizard_update_end]

    steps(*Ppsp.form_steps.keys)

    def show
      @ppsp = Ppsp.find(params[:ppsp_id])
      @step = params[:id]
      # We are using the previous step in our authorization system
      @ppsp.form_step = Ppsp.form_steps.keys[Ppsp.form_steps.keys.index(@step) - 1].to_sym unless Ppsp.form_steps.keys.index(@step).zero?
      authorize @ppsp
      usefull_variable_for_form
      render_wizard
    end

    def update
      @ppsp = Ppsp.find(params[:ppsp_id])
      authorize @ppsp
      usefull_variable_for_form
      # Use #assign_attributes since render_wizard runs a #save for us
      @ppsp.assign_attributes ppsp_params
      # if ppsp is valid, we have to save it in case of back path because it's usually save in render_wizard method which is not called ...
      if @ppsp.valid?
        action_to_launch_if_saved
        @ppsp.save if params[:back]
      end
      if params[:back]
        redirect_to(ppsp_step_path(@ppsp, previous_step))
      elsif params[:end]
        @ppsp.save ? redirect_to(finish_wizard_path) : render_wizard
      else
        render_wizard(@ppsp)
      end
    end

    private

    # Only allow the params for specific attributes allowed in this step
    def ppsp_params
      params.require(:ppsp).permit(Ppsp.form_steps[step]).merge(form_step: step.to_sym)
    end

    def finish_wizard_path
      ppsp_path(@ppsp, format: :pdf)
    end

    def set_ppsp
      @ppsp = Ppsp.find(params[:ppsp_id])
    end

    # -----------------
    # USEFUL VARIABLE DEFINITION

    def usefull_variable_for_form
      case step
      when "ppsp_designation"
        ppsp_designation_variables
      when "ppsp_master"
        ppsp_master_variables
      when "ppsp_prevention"
        ppsp_prevention_variables
      when "ppsp_security"
        ppsp_security_variables
      end
    end

    def ppsp_designation_variables
      @responsible = Worker.where(role: 'Conducteur de travaux').order(:last_name)
      @team_manager = Worker.where(role: 'Chef de chantier').order(:last_name)
      @site_manager = Worker.where(role: "Chef d'équipe").order(:last_name)
    end

    def ppsp_master_variables
      @moa = Moa.new
      @moe = Moe.new
      @subcontractor = Subcontractor.new
      @moas = policy_scope(Moa)
      @moes = policy_scope(Moe)
      @subcontractors = policy_scope(Subcontractor)
    end

    def ppsp_prevention_variables
      @security_coordinator = SecurityCoordinator.new
      @pension_insurance = PensionInsurance.new
      @regional_committee = RegionalCommittee.new
      @direcct = Direcct.new
      @work_medecine = WorkMedecine.new
      @security_coordinators = policy_scope(SecurityCoordinator)
      @pension_insurances = policy_scope(PensionInsurance)
      @regional_committees = policy_scope(RegionalCommittee)
      @direccts = policy_scope(Direcct)
      @work_medecines = policy_scope(WorkMedecine)
    end

    def ppsp_security_variables
      @hospital = Hospital.new
      @demining = Demining.new
      @sos_hand = SosHand.new
      @anti_poison = AntiPoison.new
      @deminings = policy_scope(Demining)
      @sos_hands = policy_scope(SosHand)
      @anti_poisons = policy_scope(AntiPoison)
      @hospitals = policy_scope(Hospital)
    end

    # ---------------

    # ----------------
    # ACTION BEFORE SAVING

    def action_to_launch_if_saved
      # On decale le step de 1 par rapport a ce qui devrait exister car on a deja assigne les nouvelles variable => step = step suivante
      case step
      when "ppsp_master"
        create_selected_subcontractors
      when "ppsp_team_number"
        create_selected_site_installations
      when "ppsp_installation"
        create_selected_conductors
        create_selected_altitude_works
        purge_plan_installation_if_not_selected
      when "ppsp_security"
        create_selected_lifesavers
      when "ppsp_annexes"
        create_selected_risks
      end
    end

    # On regarde quels sont les Tables jointes des conducteurs (associe au current_user) qui n'ont pas encore de PPSP
    # et on leur associe le PPSP qui vient d'etre cree
    def create_selected_conductors
      @conductors = policy_scope(Conductor.all.where(ppsp_id: nil))
      @conductors.each do |conductor|
        conductor.ppsp = @ppsp
        conductor.save!
      end
    end

    def create_selected_lifesavers
      return unless params.key?(:lifesavers)

      lifesavers = params.require(:lifesavers)
      lifesavers.shift
      lifesavers.each do |lifesaver_id|
        SelectedLifesaver.create!(ppsp_id: @ppsp.id, worker_id: lifesaver_id)
      end
    end

    def create_selected_subcontractors
      return unless params.key?(:subcontractors)

      subcontractors = params.require(:subcontractors)
      subcontractors.shift
      subcontractors.each do |subcontractor_id|
        SelectedSubcontractor.create!(ppsp_id: @ppsp.id, subcontractor_id: subcontractor_id)
      end
    end

    def create_selected_risks
      return unless params.key?(:risks)

      risks = params.require(:risks)
      risks.shift
      risks.each do |risk_id|
        SelectedRisk.create!(ppsp_id: @ppsp.id, risk_id: risk_id)
      end
    end

    def create_selected_site_installations
      return unless params.key?(:site_installations)

      site_installations = params.require(:site_installations)
      site_installations.shift
      site_installations.each do |site_installation_id|
        SelectedInstallation.create!(ppsp_id: @ppsp.id, site_installation_id: site_installation_id)
      end
    end

    def create_selected_altitude_works
      return unless params.key?(:altitude_works)

      altitude_works = params.require(:altitude_works)
      altitude_works.shift
      altitude_works.each do |altitude_work_id|
        SelectedAltitude.create!(ppsp_id: @ppsp.id, altitude_work_id: altitude_work_id)
      end
    end

    def purge_plan_installation_if_not_selected
      @ppsp.plan_installation.purge if !@ppsp.plan && @ppsp.plan_installation.attached?
    end

    # ------------------
  end
end
