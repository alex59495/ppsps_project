require 'rails_helper'

RSpec.feature "React Handling", type: :feature, js: true do

  feature 'Logged as User Admin' do
    before do
      DatabaseCleaner.strategy = :transaction
      DatabaseCleaner.clean_with(:truncation)
      @user = create(:user_admin)
      @subcontractors = create_list(:subcontractor, 5, company: @user.company)
      @risks = create_list(:risk, 5)
      @site_installations = create_list(:site_installation, 5, mobile: false)
      @altitude_works = create_list(:altitude_work, 5)
      @lifesavers = create_list(:worker, 5, company: @user.company, lifesaver: true)
      @worker_conductors = create_list(:worker, 5, company: @user.company, conductor: true, lifesaver: false)
      @ppsp = create(:ppsp, user: @user)
      category_machine1 = create(:machine_category, name: 'Engin de chantier')
      category_machine2 = create(:machine_category, name: 'Pont roulant')
      category_machine3 = create(:machine_category, name: 'Pont Fixe')
      @machine1 = create(:machine, machine_category: category_machine1, caces: 'Categorie A', description: 'Bla bla bla je suis un engin de chantier de categorie A')
      @machine2 = create(:machine, machine_category: category_machine1, caces: 'Categorie B', description: 'Bla bla bla je suis un engin de chantier de categorie B')
      @machine3 = create(:machine, machine_category: category_machine2, caces: 'Categorie A', description: 'Bla bla bla je suis un pont roulant de categorie A')
      @machine4 = create(:machine, machine_category: category_machine2, caces: 'Categorie B', description: 'Bla bla bla je suis un pont roulant de categorie B')
      @machine5 = create(:machine, machine_category: category_machine3, caces: 'Categorie A', description: 'Bla bla bla je suis un pont fixe de categorie A')
    end

    feature 'React within the form selected database' do
      before do
        login_as(@user)
      end

      scenario "Can see the list of Subcontractor's options" do
        visit(ppsp_step_path(@ppsp, "ppsp_master"))
        count = find('.form-group.check_boxes.optional.subcontractors').all('label').size
        expect(count).to eq(@subcontractors.size)
      end

      scenario "Can see the list of Risk's options" do
        # Be able to count the hidden elements
        Capybara.ignore_hidden_elements = false
        visit(ppsp_step_path(@ppsp, "ppsp_annexes"))
        count = find('.form-group.check_boxes.optional.risks').all('label').size
        expect(count).to eq(@risks.size)
        Capybara.ignore_hidden_elements = true
      end

      scenario "Can see the list of Site Installation's options" do
        visit(ppsp_step_path(@ppsp, "ppsp_team_number"))
        find('#form-site-fixe').click
        count = find('.form-group.check_boxes.optional.site_installations').all('label').size
        expect(count).to eq(@site_installations.size)
      end

      scenario "Can see the list of Altitude Work's options" do
        visit(ppsp_step_path(@ppsp, "ppsp_installation"))
        count = find('.form-group.check_boxes.optional.altitude_works').all('label').size
        expect(count).to eq(@altitude_works.size)
      end

      scenario "Can see the list of Lifesavers options" do
        visit(ppsp_step_path(@ppsp, "ppsp_security"))
        count = find('.form-group.check_boxes.optional.lifesavers').all('label').size
        expect(count).to eq(@lifesavers.size)
      end

      scenario 'When click on subcontractor option, actualize form list options + add in the addList' do
        visit(ppsp_step_path(@ppsp, "ppsp_master"))
        count_form_list = find('.form-group.check_boxes.optional.subcontractors').all('label').size
        count_add_list = find('.form-selected-subcontractor').all('label').size
        find("#check_subcontractors_#{@subcontractors.first.id}").click
        expect(find('.form-group.check_boxes.optional.subcontractors').all('label').size).to eq(count_form_list - 1)
        expect(find('.form-selected-subcontractor').all('label').size).to eq(count_add_list + 1)
      end

      scenario 'When click on risk option, actualize form list options + add in the addList' do
        visit(ppsp_step_path(@ppsp, "ppsp_annexes"))
        find("#risk_type_#{@risks.first.risk_type.name.parameterize(separator: '_')}").click
        count_form_list = find('.form-group.check_boxes.optional.risks').all('label').size
        count_add_list = find('.form-selected-risk').all('label').size
        find("#check_risks_#{@risks.first.id}").click
        expect(find('.form-group.check_boxes.optional.risks').all('label').size).to eq(count_form_list - 1)
        expect(find('.form-selected-risk').all('label').size).to eq(count_add_list + 1)
      end

      scenario 'When click on site installation option, actualize form list options + add in the addList' do
        visit(ppsp_step_path(@ppsp, "ppsp_team_number"))
        find('#form-site-fixe').click
        count_form_list = find('.form-group.check_boxes.optional.site_installations').all('label').size
        count_add_list = find('.form-selected-site_installation').all('label').size
        find("#check_site_installations_#{@site_installations.first.id}").click
        expect(find('.form-group.check_boxes.optional.site_installations').all('label').size).to eq(count_form_list - 1)
        expect(find('.form-selected-site_installation').all('label').size).to eq(count_add_list + 1)
      end

      scenario 'When click on altitude work option, actualize form list options + add in the addList' do
        visit(ppsp_step_path(@ppsp, "ppsp_installation"))
        count_form_list = find('.form-group.check_boxes.optional.altitude_works').all('label').size
        count_add_list = find('.form-selected-altitude_work').all('label').size
        find("#check_altitude_works_#{@altitude_works.first.id}").click
        expect(find('.form-group.check_boxes.optional.altitude_works').all('label').size).to eq(count_form_list - 1)
        expect(find('.form-selected-altitude_work').all('label').size).to eq(count_add_list + 1)
      end

      scenario 'When click on lifesaver option, actualize form list options + add in the addList' do
        visit(ppsp_step_path(@ppsp, "ppsp_security"))
        count_form_list = find('.form-group.check_boxes.optional.lifesavers').all('label').size
        count_add_list = find('.form-selected-lifesaver').all('label').size
        find("#check_lifesavers_#{@lifesavers.first.id}").click
        expect(find('.form-group.check_boxes.optional.lifesavers').all('label').size).to eq(count_form_list - 1)
        expect(find('.form-selected-lifesaver').all('label').size).to eq(count_add_list + 1)
      end

      feature 'When delete, actualize form list options' do
        before do
          @subcontractor_add = create_list(:subcontractor, 2, company: @user.company)
          @ppsp.subcontractors = @subcontractor_add
          @risk_add = create_list(:risk, 2)
          @ppsp.risks = @risk_add
          @altitude_work_add = create_list(:altitude_work, 2)
          @ppsp.altitude_works = @altitude_work_add
          @site_installation_add = create_list(:site_installation, 2)
          @ppsp.site_installations = @site_installation_add
          @lifesavers_add = create_list(:worker, 2, lifesaver: true, company: @user.company)
          @ppsp.workers = @lifesavers_add
        end

        scenario 'Actualize list subcontractors option when delete' do
          visit(ppsp_step_path(@ppsp, "ppsp_master"))
          count = find('#containerSelectedSubcontractors').all('.card-form-selected').size
          first('#containerSelectedSubcontractors > .card-form-selected > .card-form-delete').click
          sleep 2
          expect(find('#containerSelectedSubcontractors').all('.card-form-selected').size).to eq(count - 1)
        end

        scenario 'Actualize site installation list option when delete' do
          visit(ppsp_step_path(@ppsp, "ppsp_team_number"))
          count = find('#containerSelectedSiteInstallations').all('.card-form-selected').size
          first('#containerSelectedSiteInstallations > .card-form-selected > .card-form-delete').click
          sleep 2
          expect(find('#containerSelectedSiteInstallations').all('.card-form-selected').size).to eq(count - 1)
        end

        scenario 'Actualize risks list option when delete' do
          visit(ppsp_step_path(@ppsp, "ppsp_annexes"))
          count = find('#containerSelectedRisks').all('.card-form-selected').size
          first('#containerSelectedRisks > .card-form-selected > .card-form-delete').click
          sleep 2
          expect(find('#containerSelectedRisks').all('.card-form-selected').size).to eq(count - 1)
        end

        scenario 'Actualize altitude works list option when delete' do
          visit(ppsp_step_path(@ppsp, "ppsp_installation"))
          count = find('#containerSelectedAltitudeWorks').all('.card-form-selected').size
          first('#containerSelectedAltitudeWorks > .card-form-selected > .card-form-delete').click
          sleep 2
          expect(find('#containerSelectedAltitudeWorks').all('.card-form-selected').size).to eq(count - 1)
        end

        scenario 'Actualize lifesaver list option when delete' do
          visit(ppsp_step_path(@ppsp, "ppsp_security"))
          count = find('#containerSelectedLifesavers').all('.card-form-selected').size
          first('#containerSelectedLifesavers > .card-form-selected > .card-form-delete').click
          sleep 2
          expect(find('#containerSelectedLifesavers').all('.card-form-selected').size).to eq(count - 1)
        end
      end
    end

    feature 'Select a conductor' do
      before do
        login_as(@user)
      end

      scenario 'Button disabled when not selected option' do
        visit(ppsp_step_path(@ppsp, "ppsp_installation"))
        expect(page).to have_button('submit-category', disabled: true)
      end

      scenario 'When I select machine and conductors => Create a Conductor instance + hide the respectives forms' do
        create(:conductor, user: @user, ppsp_id: @ppsp.id, machine: @machine1)
        visit(ppsp_step_path(@ppsp, "ppsp_installation"))
        count = find('.form-conductors-selection').all('.card-vehicule').size
        # find('#formSelectCategory').find(:xpath, 'option[2]').select_option
        select @machine4.machine_category.name.to_s, from: 'formSelectCategory'
        expect(page).to have_button('submit-category', disabled: false)
        find('#submit-category').click
        expect(page).to have_selector('.form-select-machines', visible: true)
        # find('#formSelectMachine').find(:xpath, 'option[1]').select_option
        select @machine4.caces.to_s, from: 'formSelectMachine'
        find('#submit-machine').click
        expect(page).to have_selector('.checkboxes-workers', visible: true)
        check "check_worker_#{@worker_conductors.first.id}"
        find('#submit-conductors').click
        sleep 2
        expect(find('.form-conductors-selection').all('.card-vehicule').size).to eq(count + 1)
      end
    end

    feature 'Delete a conductor' do
      before do
        create(:conductor, user: @user, ppsp_id: @ppsp.id, machine: @machine1, worker: Worker.first)
        create(:conductor, user: @user, ppsp_id: @ppsp.id, machine: @machine2, worker: Worker.second)
        create(:conductor, user: @user, ppsp_id: @ppsp.id, machine: @machine3, worker: Worker.third)
      end

      before do
        login_as(@user)
      end

      scenario 'Can delete a conductor' do
        visit(ppsp_step_path(@ppsp, "ppsp_installation"))
        count = find('.form-conductors-selection').all('.card-vehicule').size
        first('.form-conductors-selection .card-vehicule .card-delete').click
        sleep 2
        expect(find('.form-conductors-selection').all('.card-vehicule').size).to eq(count - 1)
      end
    end
  end
end
