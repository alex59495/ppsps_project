require 'rails_helper'

RSpec.feature "Ppsps Views", type: :feature, js: true do
  context "Unlogged user" do
    it 'Redirect to Sign In page' do
      visit(ppsps_path)
      expect(page).to have_current_path(new_user_session_path)
    end
  end

  context 'Logged as User' do
    before do
      user = create(:user)
      @ppsp = create(:ppsp, user: user)
      login_as(user)
    end
   
    it 'Visit Ppsp index' do
      visit(ppsps_path)
      expect(page).to have_current_path(ppsps_path)
    end

    it 'Click on the Edit link' do
      visit(ppsps_path)
      click_link 'edit'
      expect(page).to have_current_path(edit_ppsp_path(@ppsp))
    end

    it 'Click on the New link' do
      visit(ppsps_path)
      click_link 'Créer un nouveau PPSP'
      expect(page).to have_current_path(new_ppsp_path)
    end

    it 'Complete and Sumbit the PPSP' do
      visit(new_ppsp_path)
      fill_in('Adresse', with: 'Test adresse')
      fill_in('Nature du travail', with: 'Test de nature')
      fill_in('Personnel impliqué', with: 'Test de personnel')
      find('#ppsp_moa_id').find(:xpath, 'option[2]').select_option
      find('#ppsp_moe_id').find(:xpath, 'option[2]').select_option
      fill_in('Référence du projet', with: "ABRFH78")
      fill_in('Responsable', with: 'Test de resposnable')
      fill_in('ppsp_project_information_attributes_phone', with: Faker::PhoneNumber.cell_phone_in_e164)
      fill_in('ppsp_project_information_attributes_email', with: Faker::Internet.email)
      fill_in('Chef de chantier', with: 'Test de chef de chantier')
      fill_in('ppsp_project_information_attributes_site_manager_attributes_phone', with: Faker::PhoneNumber.cell_phone_in_e164)
      fill_in('ppsp_project_information_attributes_site_manager_attributes_email', with: Faker::Internet.email)
      fill_in("Chef d'équipe", with: "Test de chef d'équipe")
      fill_in("ppsp_project_information_attributes_team_manager_attributes_phone", with: Faker::PhoneNumber.cell_phone_in_e164)
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
      expect {click_button 'Créer un nouveau PPSP'}.to change(Ppsp, :count).by(1)
      expect(page).to have_current_path(informations_supplementaires_ppsp_path(Ppsp.last))
    end
 
    it 'Click on the Show Page' do
      visit(ppsps_path)
      click_link @ppsp.project_information.reference
      expect(page).to have_current_path(ppsp_path(@ppsp))
    end

    it 'Show Page have content' do
      visit(ppsp_path(@ppsp))
      expect(page).to have_content('Plan Particulier de Sécurité et de Protection de la Santé')
    end

    it 'Open a new tab when click on PDF' do
      visit(ppsps_path)
      click_link('PDF')
      # Test if there is more than one tab open which would tell us if the PDF link work well opening another tab
      expect(page.driver.browser.window_handles.size).to be > 1
    end

    it 'Confirmation message when delete a Ppsp' do
      visit(ppsps_path)
      # Accept the data: { confirm: } in the view 
      msg = accept_confirm { click_link 'x' }
      expect(msg).to eq('Êtes-vous sûr de vouloir supprimer ce document ?')
    end

    it 'Delete a Ppsp when click on "x" on the Index page' do
      visit(ppsps_path)
      count = Ppsp.count
      # Accept the data: { confirm: } in the view 
      accept_confirm { click_link 'x' }
      # Had to refresh the page so that the modification is Ok
      visit current_path
      expect(Ppsp.count).to eq(count - 1)
    end
  end
end
