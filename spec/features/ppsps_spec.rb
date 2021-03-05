require 'rails_helper'

RSpec.feature "Ppsps Views", type: :feature, js: true do
  feature "Unlogged user" do
    scenario 'Redirect to Sign In page when try to access PPSP index' do
      visit(ppsps_path)
      expect(page).to have_current_path(new_user_session_path)
    end
  end

  feature 'Logged as normal User' do
    before :all do
      @user_uber = create(:user_uber)
      project_info1 = create(:project_information, reference: "AABB130")
      project_info2 = create(:project_information, reference: "AABB120")
      ppsp_1 = create(:ppsp, project_information: project_info1, user: @user_uber)
      ppsp_2 = create(:ppsp, project_information: project_info2, user: @user_uber)
      ppsp_3 = create(:ppsp_google)
    end

    before do
      login_as(@user_uber)
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
  end

  feature 'Logged as User Admin' do
    before :all do
      @user = create(:user_admin)
      moa = create(:moa, company: @user.company)
      moe = create(:moe, company: @user.company)
      direcct = create(:direcct, company: @user.company)
      pension_insurance = create(:pension_insurance, company: @user.company)
      work_medecine = create(:work_medecine, company: @user.company)
      hospital = create(:hospital, company: @user.company)
      demining = create(:demining, company: @user.company)
      anti_poison = create(:anti_poison, company: @user.company)
      regional_committee = create(:regional_committee, company: @user.company)
      sos_hand = create(:sos_hand, company: @user.company)
      security_coordinator = create(:security_coordinator, company: @user.company)
      @ppsp = create(:ppsp, user: @user, moa: moa, moe: moe, direcct: direcct, work_medecine: work_medecine, hospital: hospital, pension_insurance: pension_insurance,
                            demining: demining, anti_poison: anti_poison, regional_committee: regional_committee, sos_hand: sos_hand,
                            security_coordinator: security_coordinator)
    end

    before do
      login_as(@user)
    end

    scenario 'Visit Ppsp index' do
      visit(ppsps_path)
      expect(page).to have_current_path(ppsps_path)
    end

    scenario 'Can access and modify some databases' do
      visit(ppsps_path)
      click_on 'Modifier les bases de données'
      find('#moa').click
      # Open a new window
      first('.card-bdd').hover.find('.card-db-edit').click
      fill_in('moa_name', with: 'Update the name')
      click_button('MoaBtn')
      moas = Moa.all.order(updated_at: :desc)
      expect(page).to have_current_path(moas_path)
      expect(moas.first.name).to eq('Update the name')
    end

    scenario 'Click on the Edit link' do
      visit(ppsps_path)
      find('.card-ppsp-edit').click
      expect(page).to have_current_path(edit_ppsp_path(@ppsp))
    end

    scenario 'Click on the New link' do
      visit(ppsps_path)
      click_link 'Créer un nouveau PPSP'
      expect(page).to have_current_path(new_ppsp_path)
    end

    scenario 'Complete and Submit the PPSP' do
      count = Ppsp.includes(:user).where(users: { company: @user.company }).count
      visit(new_ppsp_path)
      fill_in('ppsp_project_information_attributes_name', with: 'Test de nom de projet')
      fill_in('ppsp_project_information_attributes_reference', with: "ABRFH78")
      find('#ppsp_project_information_attributes_responsible_id').find(:xpath, 'option[2]').select_option
      find('#ppsp_project_information_attributes_site_manager_id').find(:xpath, 'option[2]').select_option
      find('#ppsp_project_information_attributes_team_manager_id').find(:xpath, 'option[2]').select_option

      find('#ppsp_moa_id').find(:xpath, 'option[2]').select_option
      find('#ppsp_moe_id').find(:xpath, 'option[2]').select_option
      find('#ppsp_security_coordinator_id').find(:xpath, 'option[2]').select_option

      find('#ppsp_regional_committee_id').find(:xpath, 'option[2]').select_option
      find('#ppsp_pension_insurance_id').find(:xpath, 'option[2]').select_option
      find('#ppsp_direcct_id').find(:xpath, 'option[2]').select_option
      find('#ppsp_work_medecine_id').find(:xpath, 'option[2]').select_option

      fill_in('ppsp_worksite_attributes_nature', with: 'Test de nature')
      # complete the flatpickr date
      page.execute_script("$('#range_start').val('2020-12-12')")
      fill_in('range_end', with: Date.today.next_day.next_month.next_month.to_s)
      fill_in('ppsp_worksite_attributes_address', with: 'Test adresse')

      # visible false because we hide the input to make designed css element
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
      fill_in('ppsp_worksite_attributes_num_responsible', with: 1)
      fill_in('ppsp_worksite_attributes_num_conductor', with: 3)
      fill_in('ppsp_worksite_attributes_num_worker', with: 10)

      find('#ppsp_demining_id').find(:xpath, 'option[2]').select_option
      find('#ppsp_sos_hand_id').find(:xpath, 'option[2]').select_option
      find('#ppsp_anti_poison_id').find(:xpath, 'option[2]').select_option

      find('#ppsp_hospital_id').find(:xpath, 'option[2]').select_option
      click_button "J'ai terminé"
      sleep 2
      expect(Ppsp.includes(:user).where(users: { company: @user.company }).count).to eq(count + 1)
    end

    scenario 'Open a new tab when click on PDF' do
      visit(ppsps_path)
      find('.card-ppsp').click
      # Test if there is more than one tab open which would tell us if the PDF link work well opening another tab
      expect(page.driver.browser.window_handles.size).to be > 1
    end

    scenario 'Change the field when update' do
      visit(edit_ppsp_path(@ppsp))
      fill_in('ppsp_project_information_attributes_reference', with: 'Reference Updated')
      click_button("J'ai terminé")
      # A refacto
      sleep 2
      expect(@ppsp.reload.project_information.reference).to eq('Reference Updated')
    end

    scenario 'Confirmation message when delete a Ppsp' do
      visit(ppsps_path)
      # Accept the data: { confirm: } in the view
      msg = accept_confirm { find('.card-ppsp-delete').click }
      expect(msg).to eq('Êtes-vous sûr de vouloir supprimer cet élément ?')
    end

    scenario 'Delete a Ppsp when click on "x" on the Index page' do
      visit(ppsps_path)
      count = Ppsp.count
      # Accept the data: { confirm: } in the view
      accept_confirm { find('.card-ppsp-delete').click }
      # Had to refresh the page so that the modification is Ok
      visit current_path
      expect(Ppsp.count).to eq(count - 1)
    end

    describe 'FlatPickr' do
      it 'Create Form should handle a date change' do
        visit(new_ppsp_path)
        fill_in('range_start', with: Date.today.next_month.prev_day.to_s)
        fill_in('range_end', with: Date.today.next_day.next_year.next_month.next_month.to_s)
        fill_in('range_start', with: Date.today.next_month.to_s)
        fill_in('range_end', with: Date.today.next_day.next_year.next_month.next_month.to_s)
        expect(page).to have_css('.flatpickr-month')
        expect(find('#start-year-calendar')).to have_content(Date.today.next_month.year.to_s)
        expect(find('#end-year-calendar')).to have_content(Date.today.next_day.next_year.next_month.next_month.year.to_s)
        expect(find('#start-month-calendar')).to have_content(Date::ABBR_MONTHNAMES[Date.today.month + 1].to_s)
        expect(find('#end-month-calendar')).to have_content(Date::ABBR_MONTHNAMES[Date.today.next_day.month + (Date.today.next_day == 1 ? 3 : 2)].to_s)
        expect(find('#end-day-calendar')).to have_content(Date.today.next_day.next_year.next_month.next_month.day.to_s)
      end
    end

    feature 'Databases from PPSP new page' do
      before do
        login_as(@user)
        visit(new_ppsp_path)
      end

      scenario "Can add MOA from PPSP new page" do
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

      scenario "Can add MOE from PPSP new page" do
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

      scenario "Can add AntiPoison from PPSP new page" do
        count = find('#ppsp_anti_poison_id').all('option').size
        find('#AntiPoisonDb').click
        page.execute_script("$('#anti_poison_name').val('Test anti_poison')")
        page.execute_script("$('#anti_poison_address').val('Test anti_poison')")
        page.execute_script("$('#anti_poison_phone').val('0600000000')")
        find('#AntiPoisonBtn').click
        expect(page).to have_css('#ppsp_anti_poison_id > option', count: count + 1)
      end

      scenario "Can add Demining from PPSP new page" do
        count = find('#ppsp_demining_id').all('option').size
        find('#DeminingDb').click
        page.execute_script("$('#demining_name').val('Test demining')")
        page.execute_script("$('#demining_address').val('Test demining')")
        page.execute_script("$('#demining_phone').val('0600000000')")
        find('#DeminingBtn').click
        expect(page).to have_css('#ppsp_demining_id > option', count: count + 1)
      end

      scenario "Can add Sos Hand from PPSP new page" do
        count = find('#ppsp_sos_hand_id').all('option').size
        find('#SosHandDb').click
        page.execute_script("$('#sos_hand_name').val('Test sos_hand')")
        page.execute_script("$('#sos_hand_address').val('Test sos_hand')")
        page.execute_script("$('#sos_hand_phone').val('0600000000')")
        find('#SosBtn').click
        expect(page).to have_css('#ppsp_sos_hand_id > option', count: count + 1)
      end

      scenario "Can add Hospital from PPSP new page" do
        count = find('#ppsp_hospital_id').all('option').size
        find('#HospitalDb').click
        page.execute_script("$('#hospital_name').val('Test hospital')")
        page.execute_script("$('#hospital_address').val('Test hospital')")
        page.execute_script("$('#hospital_phone').val('0600000000')")
        find('#HospitalBtn').click
        expect(page).to have_css('#ppsp_hospital_id > option', count: count + 1)
      end

      scenario "Can add Direcct from PPSP new page" do
        count = find('#ppsp_direcct_id').all('option').size
        find('#DirecctDb').click
        page.execute_script("$('#direcct_fax').val('0600000000')")
        page.execute_script("$('#direcct_address').val('Test direcct')")
        page.execute_script("$('#direcct_phone').val('0600000000')")
        find('#DirecctBtn').click
        expect(page).to have_css('#ppsp_direcct_id > option', count: count + 1)
      end

      scenario "Can add Regional Committee from PPSP new page" do
        count = find('#ppsp_regional_committee_id').all('option').size
        find('#RegionalCommitteeDb').click
        page.execute_script("$('#regional_committee_name').val('Test regional_committee')")
        page.execute_script("$('#regional_committee_fax').val('0600000000')")
        page.execute_script("$('#regional_committee_address').val('Test regional_committee')")
        page.execute_script("$('#regional_committee_phone').val('0600000000')")
        find('#RegionalBtn').click
        expect(page).to have_css('#ppsp_regional_committee_id > option', count: count + 1)
      end

      scenario "Can add Pension Insurance from PPSP new page" do
        count = find('#ppsp_pension_insurance_id').all('option').size
        find('#PensionInsuranceDb').click
        page.execute_script("$('#pension_insurance_fax').val('0600000000')")
        page.execute_script("$('#pension_insurance_address').val('Test pension_insurance')")
        page.execute_script("$('#pension_insurance_phone').val('0600000000')")
        find('#PensionBtn').click
        expect(page).to have_css('#ppsp_pension_insurance_id > option', count: count + 1)
      end

      scenario "Can add Work Medecine from PPSP new page" do
        count = find('#ppsp_work_medecine_id').all('option').size
        find('#WorkMedecineDb').click
        page.execute_script("$('#work_medecine_fax').val('0600000000')")
        page.execute_script("$('#work_medecine_address').val('Test work_medecine')")
        page.execute_script("$('#work_medecine_phone').val('0600000000')")
        find('#WorkMedecineBtn').click
        expect(page).to have_css('#ppsp_work_medecine_id > option', count: count + 1)
      end

      scenario "Can add Security Coordinator from PPSP new page" do
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

      scenario "Can add Subcontractors from PPSP new page" do
        count = find('.form-group.check_boxes.optional.ppsp_subcontractors').all('label').size
        find('#SubcontractorDb').click
        page.execute_script("$('#subcontractor_name').val('Test subcontractor')")
        page.execute_script("$('#subcontractor_address').val('Test subcontractor')")
        page.execute_script("$('#subcontractor_work').val('Test work')")
        page.execute_script("$('#subcontractor_responsible_email').val('test_responsible@gmail.com')")
        page.execute_script("$('#subcontractor_responsible_name').val('Test name')")
        page.execute_script("$('#subcontractor_responsible_phone').val('0600000000')")
        find('#SubcontractorBtn').click
        sleep 2
        count_end = find('.form-group.check_boxes.optional.ppsp_subcontractors').all('label').size
        expect(count_end).to eq(count + 1)
      end

      scenario "Rerender MOA form when not filling right" do
        find('#MoaDb').click
        fill_in('moa_name', with: 'Test Moa')
        fill_in('moa_representative', with: 'Test Moa')
        fill_in('moa_email', with: 'test_moa@gmail.com')
        fill_in('moa_phone', with: '0600000000')
        find('#MoaBtn').click
        expect(page).to have_css('.is-invalid')
      end

      scenario "Rerender MOE form when not filling right" do
        find('#MoeDb').click
        fill_in('moe_name', with: 'Test moe')
        fill_in('moe_representative', with: 'Test moe')
        fill_in('moe_email', with: 'test_moe@gmail.com')
        fill_in('moe_phone', with: '0600000000')
        find('#MoeBtn').click
        expect(page).to have_css('.is-invalid')
      end

      scenario "Rerender AntiPoison when not filling right" do
        find('#AntiPoisonDb').click
        fill_in('anti_poison_address', with: 'Test anti_poison')
        fill_in('anti_poison_phone', with: '0600000000')
        find('#AntiPoisonBtn').click
        expect(page).to have_css('.is-invalid')
      end

      scenario "Rerender Demining when not filling right" do
        find('#DeminingDb').click
        fill_in('demining_address', with: 'Test demining')
        fill_in('demining_phone', with: '0600000000')
        find('#DeminingBtn').click
        expect(page).to have_css('.is-invalid')
      end

      scenario "Rerender Sos Hand when not filling right" do
        find('#SosHandDb').click
        fill_in('sos_hand_address', with: 'Test sos_hand')
        fill_in('sos_hand_phone', with: '0600000000')
        find('#SosBtn').click
        expect(page).to have_css('.is-invalid')
      end

      scenario "Rerender Hospital when not filling right" do
        find('#HospitalDb').click
        fill_in('hospital_address', with: 'Test hospital')
        fill_in('hospital_phone', with: '0600000000')
        find('#HospitalBtn').click
        expect(page).to have_css('.is-invalid')
      end

      scenario "Rerender Direcct when not filling right" do
        find('#DirecctDb').click
        fill_in('direcct_fax', with: '0600000000')
        fill_in('direcct_phone', with: '0600000000')
        find('#DirecctBtn').click
        expect(page).to have_css('.is-invalid')
      end

      scenario "Rerender Regional Committee when not filling right" do
        find('#RegionalCommitteeDb').click
        fill_in('regional_committee_name', with: 'Test regional_committee')
        fill_in('regional_committee_phone', with: '0600000000')
        fill_in('regional_committee_fax', with: '0600000000')
        find('#RegionalBtn').click
        expect(page).to have_css('.is-invalid')
      end

      scenario "Rerender Pension Insurance when not filling right" do
        find('#PensionInsuranceDb').click
        fill_in('pension_insurance_address', with: 'Test pension_insurance')
        fill_in('pension_insurance_fax', with: '0600000000')
        find('#PensionBtn').click
        expect(page).to have_css('.is-invalid')
      end

      scenario "Rerender Work Medecine when not filling right" do
        find('#WorkMedecineDb').click
        fill_in('work_medecine_address', with: 'Test work_medecine')
        fill_in('work_medecine_fax', with: '0600000000')
        find('#WorkMedecineBtn').click
        expect(page).to have_css('.is-invalid')
      end

      scenario "Rerender Security Coordinator when not filling right" do
        find('#SecurityCoordinatorDb').click
        fill_in('security_coordinator_name', with: 'Test security_coordinator')
        fill_in('security_coordinator_representative', with: 'Test rep security_coordinator')
        fill_in('security_coordinator_phone', with: '0600000000')
        fill_in('security_coordinator_email', with: 'test_representative@gmail.com')
        find('#SecurityBtn').click
        expect(page).to have_css('.is-invalid')
      end
    end
  end
end
