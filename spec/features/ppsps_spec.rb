require 'rails_helper'

RSpec.feature "Ppsps Views", type: :feature, js: true do
  let(:user) { create(:user) }
  let(:user_admin) { create(:user_admin) }
  let(:user_uber) { create(:user_uber) }
  let(:ppsp) { create(:ppsp, user: user_admin) }
  let(:ppsp_designation) { create(:ppsp_designation, user: user_uber) }
  let(:ppsp_master) { create(:ppsp_master, user: user_uber) }
  let(:ppsp_prevention) { create(:ppsp_prevention, user: user_uber) }
  let(:ppsp_worksite) { create(:ppsp_worksite, user: user_uber) }
  let(:ppsp_time_table) { create(:ppsp_time_table, user: user_uber) }
  let(:ppsp_team_number) { create(:ppsp_team_number, user: user_uber) }
  let(:ppsp_installation) { create(:ppsp_installation, user: user_uber) }
  let(:ppsp_security) { create(:ppsp_security, user: user_uber) }
  let(:responsibles) { create_list(:responsible, 10, company: user_uber.company) }
  let(:site_manager) { create_list(:site_manager, 10, company: user_uber.company) }
  let(:team_manager) { create_list(:team_manager, 10, company: user_uber.company) }
  let(:moes) { create_list(:moe, 10, company: user_uber.company) }
  let(:moas) { create_list(:moa, 10, company: user_uber.company) }
  let(:regional_committees) { create_list(:regional_committee, 10, company: user_uber.company) }
  let(:pension_insurances) { create_list(:pension_insurance, 10, company: user_uber.company) }
  let(:direccts) { create_list(:direcct, 10, company: user_uber.company) }
  let(:work_medecines) { create_list(:work_medecine, 10, company: user_uber.company) }
  let(:security_coordinators) { create_list(:security_coordinator, 10, company: user_uber.company) }
  let(:deminings) { create_list(:demining, 10, company: user_uber.company) }
  let(:sos_hands) { create_list(:sos_hand, 10, company: user_uber.company) }
  let(:anti_poisons) { create_list(:anti_poison, 10, company: user_uber.company) }
  let(:hospitals) { create_list(:hospital, 10, company: user_uber.company) }

  feature "Unlogged user" do
    scenario 'Redirect to Sign In page when try to access PPSP index' do
      visit(ppsps_path)
      expect(page).to have_current_path(new_user_session_path)
    end
  end

  feature 'Logged as normal User' do
    before do
      create(:ppsp, reference: "AABB130", user: user_uber)
      create(:ppsp, reference: "AABB120", user: user_uber)
      create(:ppsp_google)
    end

    before do
      login_as(user_uber)
    end

    scenario "Can't access the Database" do
      visit(ppsps_path)
      expect { find('a', text: 'Modifier les bases de données') }.to raise_error(Capybara::ElementNotFound)
    end

    scenario "Only the see the Ppsp of his company" do
      visit(ppsps_path)
      expect(page).to have_css('.card-ppsp', count: 2)
    end

    scenario "The search bar is working" do
      visit(ppsps_path)
      find('.search-ppsp').set("AABB130")
      expect(page).to have_css('.card-ppsp', count: 1)
    end

    context 'Ppsp Wizard' do
      scenario 'designation' do
        responsibles
        site_manager
        team_manager
        visit(new_ppsp_path)
        fill_in('ppsp_name', with: 'Test de nom de projet')
        fill_in('ppsp_reference', with: "ABRFH78")
        find('#ppsp_responsible_id').find(:xpath, 'option[2]').select_option
        find('#ppsp_site_manager_id').find(:xpath, 'option[2]').select_option
        find('#ppsp_team_manager_id').find(:xpath, 'option[2]').select_option
        click_on(id: 'link-next')
        # We are waiting for the other page to load in order to be sure that the whole process is finished
        find('#ppsp_moa_id')
        expect(Ppsp.all.order(updated_at: :desc).first.reference).to eq("ABRFH78")
      end

      scenario 'master' do
        moes
        moas
        visit(ppsp_step_path(ppsp_designation, "ppsp_master"))
        find('#ppsp_moa_id').find(:xpath, 'option[2]').select_option
        find('#ppsp_moe_id').find(:xpath, 'option[2]').select_option
        click_on(id: 'link-next')
        find('#ppsp_regional_committee_id')
        expect(Ppsp.last.moe).not_to be(nil)
      end

      scenario 'prevention' do
        regional_committees
        pension_insurances
        direccts
        work_medecines
        security_coordinators
        visit(ppsp_step_path(ppsp_master, "ppsp_prevention"))
        find('#ppsp_security_coordinator_id').find(:xpath, 'option[2]').select_option
        find('#ppsp_regional_committee_id').find(:xpath, 'option[2]').select_option
        find('#ppsp_pension_insurance_id').find(:xpath, 'option[2]').select_option
        find('#ppsp_direcct_id').find(:xpath, 'option[2]').select_option
        find('#ppsp_work_medecine_id').find(:xpath, 'option[2]').select_option
        click_on(id: 'link-next')
        find('#ppsp_nature')
        expect(Ppsp.last.regional_committee).not_to be(nil)
      end

      scenario 'worksite' do
        visit(ppsp_step_path(ppsp_prevention, "ppsp_worksite"))
        fill_in('ppsp_nature', with: 'Test de nature')
        fill_in('ppsp_address', with: "New York, NY")
        # complete the flatpickr date
        page.execute_script("$('#range_start').val('2020-12-12')")
        fill_in('range_end', with: Date.today.next_day.next_month.next_month.to_s)
        click_on(id: 'link-next')
        find('#timetable-summer label')
        expect(Ppsp.last.nature).to eq('Test de nature')
      end

      scenario 'time_table' do
        visit(ppsp_step_path(ppsp_worksite, "ppsp_time_table"))
        find('#timetable-summer label').click
        page.execute_script("$('#time_summer_start').val('07:00')")
        page.execute_script("$('#time_summer_end').val('16:30')")
        page.execute_script("$('#time_summer_start_friday').val('07:00')")
        page.execute_script("$('#time_summer_end_friday').val('16:00')")

        find('#timetable-winter label').click
        page.execute_script("$('#time_winter_start').val('07:00')")
        page.execute_script("$('#time_winter_end').val('16:30')")
        page.execute_script("$('#time_winter_start_friday').val('07:00')")
        page.execute_script("$('#time_winter_end_friday').val('16:00')")
        click_on(id: 'link-next')
        find('#ppsp_num_responsible')
        expect(Ppsp.last.timetable_winter_start).not_to be(nil)
      end

      scenario 'team_number' do
        visit(ppsp_step_path(ppsp_time_table, "ppsp_team_number"))
        fill_in('ppsp_num_responsible', with: 1)
        fill_in('ppsp_num_conductor', with: 3)
        fill_in('ppsp_num_worker', with: 10)
        click_on(id: 'link-next')
        find('#react-render-altitude-works')
        expect(Ppsp.last.num_conductor).to eq(3)
      end

      scenario 'security' do
        deminings
        sos_hands
        anti_poisons
        hospitals
        visit(ppsp_step_path(ppsp_installation, "ppsp_security"))
        find('#ppsp_demining_id').find(:xpath, 'option[2]').select_option
        find('#ppsp_sos_hand_id').find(:xpath, 'option[2]').select_option
        find('#ppsp_anti_poison_id').find(:xpath, 'option[2]').select_option
        find('#ppsp_hospital_id').find(:xpath, 'option[2]').select_option
        click_on(id: 'link-next')
        find('#react-render-risks')
        expect(Ppsp.last.demining).not_to be(nil)
      end

      # scenario 'ppsp_completed' do
      #   visit(ppsp_step_path(ppsp_security, "ppsp_annexes"))
      #   click_on(id: 'SubmitPpspsFormBtn')
      #   expect(page).to have_selector('#show-pdf')
      # end

      scenario 'Save a data after going back in Ppsp wizard' do
        ppsp = create(:ppsp, user: user_uber)
        visit(ppsp_step_path(ppsp, "ppsp_worksite"))
        fill_in('ppsp_nature', with: 'Modification Test de nature')
        click_on(id: 'link-previous')
        expect(Ppsp.last.nature).to eq('Modification Test de nature')
      end
    end
  end

  feature 'Logged as User Admin' do
    before do
      login_as(user_admin)
    end

    scenario 'Visit Ppsp index' do
      visit(ppsps_path)
      expect(page).to have_current_path(ppsps_path)
    end

    scenario 'Can access and modify some databases' do
      moa = create(:moa, company: user_admin.company)
      visit(ppsps_path)
      click_on 'Modifier les bases de données'
      find('#moa').click
      first('.card-bdd').hover.find('.card-db-edit').click
      find('.moa_name')
      expect(page).to have_current_path(edit_moa_path(moa))
      fill_in('moa_name', with: 'Update the name')
      click_button('MoaBtn')
      moas = Moa.all.order(updated_at: :desc)
      sleep 2
      expect(page).to have_current_path(moas_path)
      expect(moas.first.name).to eq('Update the name')
    end

    scenario 'Click on the Edit link' do
      ppsp
      visit(ppsps_path)
      find('.card-ppsp-edit').click
      expect(page).to have_current_path(edit_ppsp_path(ppsp))
    end

    scenario 'Click on the New link' do
      visit(ppsps_path)
      click_link 'Créer un nouveau PPSP'
      expect(page).to have_current_path(new_ppsp_path)
    end

    scenario 'Open a new tab when click on PDF' do
      ppsp
      visit(ppsps_path)  # let(:user) { create(:user_admin) }

      # context 'Logged as User Admin' do
      #   let(:moa) { create(:moa) }
      #   let(:moe) { create(:moe) }
      #   let(:security_coordinator) { create(:security_coordinator) }
      #   let(:site_manager) { create(:site_manager) }
      #   let(:team_manager) { create(:team_manager) }
      #   let(:direcct) { create(:moa) }
      #   let(:regional_committee) { create(:regional_committee) }
      #   let(:pension_insurance) { create(:pension_insurance) }
      #   let(:work_medecine) { create(:work_medecine) }
      #   let(:hospital) { create(:hospital) }
      #   let(:sos_hand) { create(:sos_hand) }
      #   let(:anti_poison) { create(:anti_poison) }
      #   let(:demining) { create(:demining) }
      #   let(:direcct) { create(:direcct) }
      #   let(:responsible) { create(:responsible) }
      #   let(:site_manager) { create(:site_manager) }
      #   let(:team_manager) { create(:team_manager) }
      #   let(:responsible) { create(:responsible) }
      #   let(:site_manager) { create(:site_manager) }
      #   let(:team_manager) { create(:team_manager) }
      #   let(:params_ppsp) do
      #     attributes_for(:ppsp).merge({
      #                                   security_coordinator_id: security_coordinator.id,
      #                                   moa_id: moa.id,
      #                                   moe_id: moe.id,
      #                                   direcct_id: direcct.id,
      #                                   regional_committee_id: regional_committee.id,
      #                                   pension_insurance_id: pension_insurance.id,
      #                                   work_medecine_id: work_medecine.id,
      #                                   hospital_id: hospital.id,
      #                                   sos_hand_id: sos_hand.id,
      #                                   anti_poison_id: anti_poison.id,
      #                                   user_id: user.id,
      #                                   demining_id: demining.id
      #                                 })
      #   end
    
      #   context 'Actions when you are the record owner' do
      #     let(:ppsp) { create(:ppsp, user: user) }
    
      #     before do
      #       login_as(user)
      #     end
    
      #     context 'Action Create' do
      #       let(:create_action) { post ppsps_path, params: { ppsp: params_ppsp } }
    
      #       it 'Add one instance of Ppsp when using create' do
      #         expect { create_action }.to change(Ppsp, :count).by(1)
      #       end
    
      #       it 'Redirect after create' do
      #         create_action
      #         expect(response).to have_http_status(302)
      #       end
      #     end
    
      #     context 'Action Update' do
      #       let(:update_action) { patch ppsp_path(ppsp), params: { ppsp: params_ppsp } }
    
      #       it 'Update address of PPSP' do
      #         params_ppsp[:nature] = 'Update the nature'
      #         update_action
      #         expect(ppsp.reload.worksite.nature).to eq('Update the nature')
      #       end
    
      #       it 'Redirect after update' do
      #         update_action
      #         expect(response).to have_http_status(302)
      #       end
      #     end
      #   end
    
      #   context "Actions when you're not the record owner" do
      #     let(:ppsp) { create(:ppsp) }
      #     let(:user) { create(:user) }
    
      #     before do
      #       login_as(user)
      #     end
    
      #     it "Can't update PPSP" do
      #       expect { patch step_ppsp_path(ppsp, "ppsp_designation"), params: { ppsp: params_ppsp } }.to raise_error(Pundit::NotAuthorizedError)
      #     end
      #   end
      # end
      find('.card-ppsp').click
      # Test if there is more than one tab open which would tell us if the PDF link work well opening another tab
      expect(page.driver.browser.window_handles.size).to be > 1
    end

    scenario 'Access the edit page' do
      ppsp_edit = create(:ppsp, user: user_admin)
      visit(edit_ppsp_path(ppsp_edit))
      expect(page).to have_current_path(edit_ppsp_path(ppsp_edit))
    end

    scenario 'Confirmation message when delete a Ppsp' do
      ppsp
      visit(ppsps_path)
      # Accept the data: { confirm: } in the view
      msg = accept_confirm { find('.card-ppsp-delete').click }
      expect(msg).to eq('Êtes-vous sûr de vouloir supprimer cet élément ?')
    end

    scenario 'Delete a Ppsp when click on "x" on the Index page' do
      ppsp
      visit(ppsps_path)
      count = Ppsp.count
      # Accept the data: { confirm: } in the view
      accept_confirm { find('.card-ppsp-delete').click }
      # Had to refresh the page so that the modification is Ok
      visit current_path
      expect(Ppsp.count).to eq(count - 1)
    end

    scenario "Can add MOA from Ppsp Wizard" do
      visit(ppsp_step_path(ppsp, "ppsp_master"))
      count = find('#ppsp_moa_id').all('option').size
      find('#MoaDb').click
      page.execute_script("$('#moa_name').val('Test moa')")
      page.execute_script("$('#moa_address').val('Test moa')")
      page.execute_script("$('#moa_representative').val('Test moa')")
      page.execute_script("$('#moa_email').val('test_moa@gmail.com')")
      page.execute_script("$('#moa_phone').val('0600000000')")
      find('#MoaBtn').click
      expect(page).to have_css('#ppsp_moa_id > option', count: count + 1)
    end

    scenario "Can add MOE from Ppsp Wizard" do
      visit(ppsp_step_path(ppsp, "ppsp_master"))
      count = find('#ppsp_moe_id').all('option').size
      find('#MoeDb').click
      page.execute_script("$('#moe_name').val('Test moe')")
      page.execute_script("$('#moe_address').val('Test moe')")
      page.execute_script("$('#moe_representative').val('Test moe')")
      page.execute_script("$('#moe_email').val('test_moe@gmail.com')")
      page.execute_script("$('#moe_phone').val('0600000000')")
      find('#MoeBtn').click
      expect(page).to have_css('#ppsp_moe_id > option', count: count + 1)
    end

    scenario "Can add AntiPoison from Ppsp Wizard" do
      visit(ppsp_step_path(ppsp, "ppsp_security"))
      count = find('#ppsp_anti_poison_id').all('option').size
      find('#AntiPoisonDb').click
      page.execute_script("$('#anti_poison_name').val('Test anti_poison')")
      page.execute_script("$('#anti_poison_address').val('Test anti_poison')")
      page.execute_script("$('#anti_poison_phone').val('0600000000')")
      find('#AntiPoisonBtn').click
      expect(page).to have_css('#ppsp_anti_poison_id > option', count: count + 1)
    end

    scenario "Can add Demining from Ppsp Wizard" do
      visit(ppsp_step_path(ppsp, "ppsp_security"))
      count = find('#ppsp_demining_id').all('option').size
      find('#DeminingDb').click
      page.execute_script("$('#demining_name').val('Test demining')")
      page.execute_script("$('#demining_address').val('Test demining')")
      page.execute_script("$('#demining_phone').val('0600000000')")
      find('#DeminingBtn').click
      expect(page).to have_css('#ppsp_demining_id > option', count: count + 1)
    end

    scenario "Can add Sos Hand from Ppsp Wizard" do
      visit(ppsp_step_path(ppsp, "ppsp_security"))
      count = find('#ppsp_sos_hand_id').all('option').size
      find('#SosHandDb').click
      page.execute_script("$('#sos_hand_name').val('Test sos_hand')")
      page.execute_script("$('#sos_hand_address').val('Test sos_hand')")
      page.execute_script("$('#sos_hand_phone').val('0600000000')")
      find('#SosBtn').click
      expect(page).to have_css('#ppsp_sos_hand_id > option', count: count + 1)
    end

    scenario "Can add Hospital from Ppsp Wizard" do
      visit(ppsp_step_path(ppsp, "ppsp_security"))
      count = find('#ppsp_hospital_id').all('option').size
      find('#HospitalDb').click
      page.execute_script("$('#hospital_name').val('Test hospital')")
      page.execute_script("$('#hospital_address').val('Test hospital')")
      page.execute_script("$('#hospital_phone').val('0600000000')")
      find('#HospitalBtn').click
      expect(page).to have_css('#ppsp_hospital_id > option', count: count + 1)
    end

    scenario "Can add Direcct from Ppsp Wizard" do
      visit(ppsp_step_path(ppsp, "ppsp_prevention"))
      count = find('#ppsp_direcct_id').all('option').size
      find('#DirecctDb').click
      page.execute_script("$('#direcct_fax').val('0600000000')")
      page.execute_script("$('#direcct_address').val('Test direcct')")
      page.execute_script("$('#direcct_phone').val('0600000000')")
      find('#DirecctBtn').click
      expect(page).to have_css('#ppsp_direcct_id > option', count: count + 1)
    end

    scenario "Can add Regional Committee from Ppsp Wizard" do
      visit(ppsp_step_path(ppsp, "ppsp_prevention"))
      count = find('#ppsp_regional_committee_id').all('option').size
      find('#RegionalCommitteeDb').click
      page.execute_script("$('#regional_committee_name').val('Test regional_committee')")
      page.execute_script("$('#regional_committee_fax').val('0600000000')")
      page.execute_script("$('#regional_committee_address').val('Test regional_committee')")
      page.execute_script("$('#regional_committee_phone').val('0600000000')")
      find('#RegionalBtn').click
      expect(page).to have_css('#ppsp_regional_committee_id > option', count: count + 1)
    end

    scenario "Can add Pension Insurance from Ppsp Wizard" do
      visit(ppsp_step_path(ppsp, "ppsp_prevention"))
      count = find('#ppsp_pension_insurance_id').all('option').size
      find('#PensionInsuranceDb').click
      page.execute_script("$('#pension_insurance_fax').val('0600000000')")
      page.execute_script("$('#pension_insurance_address').val('Test pension_insurance')")
      page.execute_script("$('#pension_insurance_phone').val('0600000000')")
      find('#PensionBtn').click
      expect(page).to have_css('#ppsp_pension_insurance_id > option', count: count + 1)
    end

    scenario "Can add Work Medecine from Ppsp Wizard" do
      visit(ppsp_step_path(ppsp, "ppsp_prevention"))
      count = find('#ppsp_work_medecine_id').all('option').size
      find('#WorkMedecineDb').click
      page.execute_script("$('#work_medecine_fax').val('0600000000')")
      page.execute_script("$('#work_medecine_address').val('Test work_medecine')")
      page.execute_script("$('#work_medecine_phone').val('0600000000')")
      find('#WorkMedecineBtn').click
      expect(page).to have_css('#ppsp_work_medecine_id > option', count: count + 1)
    end

    scenario "Can add Security Coordinator from Ppsp Wizard" do
      visit(ppsp_step_path(ppsp, "ppsp_prevention"))
      count = find('#ppsp_security_coordinator_id').all('option').size
      find('#SecurityCoordinatorDb').click
      page.execute_script("$('#security_coordinator_name').val('Test security_coordinator')")
      page.execute_script("$('#security_coordinator_address').val('Test security_coordinator')")
      page.execute_script("$('#security_coordinator_representative').val('Test security_coordinator')")
      page.execute_script("$('#security_coordinator_email').val('test_representative@gmail.com')")
      page.execute_script("$('#security_coordinator_phone').val('0600000000')")
      find('#SecurityBtn').click
      expect(page).to have_css('#ppsp_security_coordinator_id > option', count: count + 1)
    end

    scenario "Can add Subcontractors from Ppsp Wizard" do
      ppsp
      subcontractor = create(:subcontractor, company: user_admin.company)
      create(:selected_subcontractor, ppsp: ppsp, subcontractor: subcontractor)
      visit(ppsp_step_path(ppsp, "ppsp_master"))
      count = find('.form-group.check_boxes.optional.subcontractors').all('label').size
      find('#SubcontractorDb').click
      page.execute_script("$('#subcontractor_name').val('Test subcontractor')")
      page.execute_script("$('#subcontractor_address').val('Test subcontractor')")
      page.execute_script("$('#subcontractor_work').val('Test work')")
      page.execute_script("$('#subcontractor_responsible_email').val('test_responsible@gmail.com')")
      page.execute_script("$('#subcontractor_responsible_name').val('Test name')")
      page.execute_script("$('#subcontractor_responsible_phone').val('0600000000')")
      find('#SubcontractorBtn').click
      sleep 2
      count_end = find('.form-group.check_boxes.optional.subcontractors').all('label').size
      expect(count_end).to eq(count + 1)
    end

    scenario "Rerender MOA form when not filling right" do
      visit(ppsp_step_path(ppsp, "ppsp_master"))
      find('#MoaDb').click
      fill_in('moa_name', with: 'Test Moa')
      fill_in('moa_representative', with: 'Test Moa')
      fill_in('moa_email', with: 'test_moa@gmail.com')
      fill_in('moa_phone', with: '0600000000')
      find('#MoaBtn').click
      expect(page).to have_css('.is-invalid')
    end

    scenario "Rerender MOE form when not filling right" do
      visit(ppsp_step_path(ppsp, "ppsp_master"))
      find('#MoeDb').click
      fill_in('moe_name', with: 'Test moe')
      fill_in('moe_representative', with: 'Test moe')
      fill_in('moe_email', with: 'test_moe@gmail.com')
      fill_in('moe_phone', with: '0600000000')
      find('#MoeBtn').click
      expect(page).to have_css('.is-invalid')
    end

    scenario "Rerender AntiPoison when not filling right" do
      visit(ppsp_step_path(ppsp, "ppsp_security"))
      find('#AntiPoisonDb').click
      fill_in('anti_poison_address', with: 'Test anti_poison')
      fill_in('anti_poison_phone', with: '0600000000')
      find('#AntiPoisonBtn').click
      expect(page).to have_css('.is-invalid')
    end

    scenario "Rerender Demining when not filling right" do
      visit(ppsp_step_path(ppsp, "ppsp_security"))
      find('#DeminingDb').click
      fill_in('demining_address', with: 'Test demining')
      fill_in('demining_phone', with: '0600000000')
      find('#DeminingBtn').click
      expect(page).to have_css('.is-invalid')
    end

    scenario "Rerender Sos Hand when not filling right" do
      visit(ppsp_step_path(ppsp, "ppsp_security"))
      find('#SosHandDb').click
      fill_in('sos_hand_address', with: 'Test sos_hand')
      fill_in('sos_hand_phone', with: '0600000000')
      find('#SosBtn').click
      expect(page).to have_css('.is-invalid')
    end

    scenario "Rerender Hospital when not filling right" do
      visit(ppsp_step_path(ppsp, "ppsp_security"))
      find('#HospitalDb').click
      fill_in('hospital_address', with: 'Test hospital')
      fill_in('hospital_phone', with: '0600000000')
      find('#HospitalBtn').click
      expect(page).to have_css('.is-invalid')
    end

    scenario "Rerender Direcct when not filling right" do
      visit(ppsp_step_path(ppsp, "ppsp_prevention"))
      find('#DirecctDb').click
      fill_in('direcct_fax', with: '0600000000')
      fill_in('direcct_phone', with: '0600000000')
      find('#DirecctBtn').click
      expect(page).to have_css('.is-invalid')
    end

    scenario "Rerender Regional Committee when not filling right" do
      visit(ppsp_step_path(ppsp, "ppsp_prevention"))
      find('#RegionalCommitteeDb').click
      fill_in('regional_committee_name', with: 'Test regional_committee')
      fill_in('regional_committee_phone', with: '0600000000')
      fill_in('regional_committee_fax', with: '0600000000')
      find('#RegionalBtn').click
      expect(page).to have_css('.is-invalid')
    end

    scenario "Rerender Pension Insurance when not filling right" do
      visit(ppsp_step_path(ppsp, "ppsp_prevention"))
      find('#PensionInsuranceDb').click
      fill_in('pension_insurance_address', with: 'Test pension_insurance')
      fill_in('pension_insurance_fax', with: '0600000000')
      find('#PensionBtn').click
      expect(page).to have_css('.is-invalid')
    end

    scenario "Rerender Work Medecine when not filling right" do
      visit(ppsp_step_path(ppsp, "ppsp_prevention"))
      find('#WorkMedecineDb').click
      fill_in('work_medecine_address', with: 'Test work_medecine')
      fill_in('work_medecine_fax', with: '0600000000')
      find('#WorkMedecineBtn').click
      expect(page).to have_css('.is-invalid')
    end

    scenario "Rerender Security Coordinator when not filling right" do
      visit(ppsp_step_path(ppsp, "ppsp_prevention"))
      find('#SecurityCoordinatorDb').click
      fill_in('security_coordinator_name', with: 'Test security_coordinator')
      fill_in('security_coordinator_representative', with: 'Test rep security_coordinator')
      fill_in('security_coordinator_phone', with: '0600000000')
      fill_in('security_coordinator_email', with: 'test_representative@gmail.com')
      find('#SecurityBtn').click
      expect(page).to have_css('.is-invalid')
    end
  end

    # describe 'FlatPickr' do
    #   it 'Create Form should handle a date change' do
    #     visit(ppsp_step_path(ppsp, "ppsp_worksite"))
    #     fill_in('range_start', with: Date.today.next_month.prev_day.to_s)
    #     fill_in('range_end', with: Date.today.next_day.next_year.next_month.next_month.to_s)
    #     fill_in('range_start', with: Date.today.next_month.to_s)
    #     fill_in('range_end', with: Date.today.next_day.next_year.next_month.next_month.to_s)
    #     expect(page).to have_css('.flatpickr-month')
    #     expect(find('#start-year-calendar')).to have_content(Date.today.next_month.year.to_s)
    #     expect(find('#end-year-calendar')).to have_content(Date.today.next_day.next_year.next_month.next_month.year.to_s)
    #     expect(find('#start-month-calendar')).to have_content(Date::ABBR_MONTHNAMES[Date.today.month + 1].to_s)
    #     expect(find('#end-month-calendar')).to have_content(Date::ABBR_MONTHNAMES[Date.today.next_day.month + (Date.today.next_day == 1 ? 3 : 2)].to_s)
    #     expect(find('#end-day-calendar')).to have_content(Date.today.next_day.next_year.next_month.next_month.day.to_s)
    #   end
    # end

end
