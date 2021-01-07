require 'rails_helper'

RSpec.feature "Ppsps Views", type: :feature, js: true do
  feature "Unlogged user" do
    scenario 'Redirect to Sign In page when try to access PPSP index' do
      visit(ppsps_path)
      expect(page).to have_current_path(new_user_session_path)
    end
  end

  feature 'Logged as normal User' do
    before do
      user_uber = create(:user_uber)
      project_info1 = create(:project_information, reference: "AABB130")
      project_info2 = create(:project_information, reference: "AABB120")
      @ppsp_1 = create(:ppsp, project_information: project_info1, user: user_uber)
      @ppsp_2 = create(:ppsp, project_information: project_info2, user: user_uber)
      @ppsp_3 = create(:ppsp_google)
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
  end

  feature 'Logged as User Admin' do
    before do
      user = create(:user_admin)
      moa = create(:moa, company: user.company)
      moe = create(:moe, company: user.company)
      direcct = create(:direcct, company: user.company)
      pension_insurance = create(:pension_insurance, company: user.company)
      work_medecine = create(:work_medecine, company: user.company)
      hospital = create(:hospital, company: user.company)
      demining = create(:demining, company: user.company)
      anti_poison = create(:anti_poison, company: user.company)
      regional_committee = create(:regional_committee, company: user.company)
      sos_hand = create(:sos_hand, company: user.company)
      security_coordinator = create(:security_coordinator, company: user.company)
      @ppsp = create(:ppsp, user: user, moa: moa, moe: moe, direcct: direcct, work_medecine: work_medecine, hospital: hospital, pension_insurance: pension_insurance,
                            demining: demining, anti_poison: anti_poison, regional_committee: regional_committee, sos_hand: sos_hand, security_coordinator: security_coordinator)
      login_as(user)
    end

    scenario 'Visit Ppsp index' do
      visit(ppsps_path)
      expect(page).to have_current_path(ppsps_path)
    end

    scenario 'Can access and modify some databases' do
      visit(ppsps_path)
      click_link 'Modifier les bases de données'
      find('.moa').click
      # Open a new window
      first('.card-database').find('.card-db-edit').click
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

    scenario 'Complete and Sumbit the PPSP' do
      visit(new_ppsp_path)
      fill_in('ppsp_address', with: 'Test adresse')
      fill_in('ppsp_nature', with: 'Test de nature')
      fill_in('ppsp_workforce', with: 'Test de personnel')
      # complete the flatpickr date
      page.execute_script("$('#startDate').val('21/12/2019')")
      page.execute_script("$('#endDate').val('21/12/2020')")
      find('#ppsp_moa_id').find(:xpath, 'option[2]').select_option
      find('#ppsp_moe_id').find(:xpath, 'option[2]').select_option
      fill_in('ppsp_project_information_attributes_reference', with: "ABRFH78")
      fill_in('ppsp_project_information_attributes_responsible', with: 'Test de responsable')
      fill_in('ppsp_project_information_attributes_phone', with: Faker::PhoneNumber.cell_phone_in_e164)
      fill_in('ppsp_project_information_attributes_email', with: Faker::Internet.email)
      fill_in('ppsp_project_information_attributes_site_manager_attributes_name', with: 'Test de chef de chantier')
      fill_in('ppsp_project_information_attributes_site_manager_attributes_phone',
              with: Faker::PhoneNumber.cell_phone_in_e164)
      fill_in('ppsp_project_information_attributes_site_manager_attributes_email', with: Faker::Internet.email)
      fill_in("ppsp_project_information_attributes_team_manager_attributes_name", with: "Test de chef d'équipe")
      fill_in("ppsp_project_information_attributes_team_manager_attributes_phone",
              with: Faker::PhoneNumber.cell_phone_in_e164)
      fill_in("ppsp_project_information_attributes_team_manager_attributes_email", with: Faker::Internet.email)
      find('#ppsp_direcct_id').find(:xpath, 'option[2]').select_option
      find('#ppsp_work_medecine_id').find(:xpath, 'option[2]').select_option
      find('#ppsp_demining_id').find(:xpath, 'option[2]').select_option
      find('#ppsp_regional_committee_id').find(:xpath, 'option[2]').select_option
      find('#ppsp_pension_insurance_id').find(:xpath, 'option[2]').select_option
      find('#ppsp_sos_hand_id').find(:xpath, 'option[2]').select_option
      find('#ppsp_anti_poison_id').find(:xpath, 'option[2]').select_option
      find('#ppsp_hospital_id').find(:xpath, 'option[2]').select_option
      find('#ppsp_security_coordinator_id').find(:xpath, 'option[2]').select_option
      find('#ppsp_agglomeration').find(:xpath, 'option[2]').select_option
      find('#ppsp_street_impact').find(:xpath, 'option[2]').select_option
      find('#ppsp_river_guidance').find(:xpath, 'option[2]').select_option
      click_button 'Créer un nouveau PPSP'
      expect(page).to have_current_path(informations_supplementaires_ppsp_path(Ppsp.last))
    end

    scenario 'Show Page have content' do
      visit(ppsp_path(@ppsp))
      expect(page).to have_content('Plan Particulier de Sécurité et de Protection de la Santé')
    end

    scenario 'Open a new tab when click on PDF' do
      visit(ppsps_path)
      find('.card-ppsp').click
      # Test if there is more than one tab open which would tell us if the PDF link work well opening another tab
      expect(page.driver.browser.window_handles.size).to be > 1
    end

    scenario 'Change the field when update' do
      visit(edit_ppsp_path(@ppsp))
      fill_in('ppsp_project_information_attributes_site_manager_attributes_name', with: 'Update chef de chantier')
      expect { click_button('Mettre à jour le PPSP') }.to change { @ppsp.reload.project_information.site_manager.name }
        .from('Test de chef de chantier')
        .to('Update chef de chantier')
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
  end

  feature 'Informations Supplémentaires' do
    before do
      user = create(:user)
      @ppsp = create(:ppsp, user: user)
      login_as(user)
    end

    let(:risks) { @risks = create_list(:risk, 5) }
    let(:site_installations) { @site_installations = create_list(:site_installation, 5) }
    let(:altitude_works) { @altitude_works = create_list(:altitude_work_select, 5) }

    scenario 'Can add some site installations' do
      site_installations
      visit informations_supplementaires_ppsp_path(@ppsp)
      find('#CheckSiteInstallation').click
      find('#SiteInstallationMobile').click
      find("#label_selected_installation_site_installation_id_#{@site_installations.first.id}").click
      find("#label_selected_installation_site_installation_id_#{@site_installations.second.id}").click
      find('#FormSiteInstallation').click
      expect(page).to have_selector('.card-info')
    end

    scenario 'Can add one altitude work' do
      altitude_works
      visit informations_supplementaires_ppsp_path(@ppsp)
      find('#CheckAltitudeWork').click
      find("#label_selected_altitude_altitude_work_id_#{@altitude_works.sample.id}").click
      find('#FormAltitudeWork').click
      expect(page).to have_selector('.card-info')
    end

    scenario 'Can add some risks' do
      risks
      visit informations_supplementaires_ppsp_path(@ppsp)
      find("#label_selected_risk_risk_id_#{@risks.first.id}").click
      find("#label_selected_risk_risk_id_#{@risks.second.id}").click
      find('#FormSelectedRisk').click
      expect(page).to have_selector('.card-info')
    end

    scenario 'Can delete risk' do
      risks
      visit informations_supplementaires_ppsp_path(@ppsp)
      find("#label_selected_risk_risk_id_#{@risks.first.id}").click
      find('#FormSelectedRisk').click
      expect(page).to have_selector('.card-info')
      accept_confirm { find('.card-info-delete').click }
      visit current_path
      expect(page).not_to have_selector('.card-info')
    end

    scenario 'Can delete altitude work' do
      altitude_works
      visit informations_supplementaires_ppsp_path(@ppsp)
      find('#CheckAltitudeWork').click
      find("#label_selected_altitude_altitude_work_id_#{@altitude_works.sample.id}").click
      find('#FormAltitudeWork').click
      expect(page).to have_selector('.card-info')
      accept_confirm { find('.card-info-delete').click }
      visit current_path
      expect(page).not_to have_selector('.card-info')
    end

    scenario 'Can delete site installation' do
      site_installations
      visit informations_supplementaires_ppsp_path(@ppsp)
      find('#CheckSiteInstallation').click
      find('#SiteInstallationMobile').click
      find("#label_selected_installation_site_installation_id_#{@site_installations.first.id}").click
      find('#FormSiteInstallation').click
      expect(page).to have_selector('.card-info')
      accept_confirm { find('.card-info-delete').click }
      visit current_path
      expect(page).not_to have_selector('.card-info')
    end
  end
end
