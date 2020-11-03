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
      user = create(:user)
      @ppsp = create(:ppsp, user: user)
      login_as(user)
    end

    scenario "Can't access the Database" do
      visit(ppsps_path)
      expect{ find('a', text: 'Modifier les bases de données') }.to raise_error(Capybara::ElementNotFound)
    end
  end


  feature 'Logged as User Admin' do
    before do
      user = create(:user_admin)
      @ppsp = create(:ppsp, user: user)
      login_as(user)
    end
   
    scenario 'Visit Ppsp index' do
      visit(ppsps_path)
      expect(page).to have_current_path(ppsps_path)
    end

    scenario 'Can access and modify some databases' do
      visit(ppsps_path)
      click_link 'Modifier les bases de données'
      click_link "Voir la liste des maitres d'ouvrage"
      first('.card-database').click_link('Edit')
      fill_in('moa_name', with: 'Update the name')
      click_button('Modifier ce MOA')
      moas = Moa.all.order(updated_at: :desc)
      expect(moas.first.name).to eq('Update the name')
    end

    scenario 'Click on the Edit link' do
      visit(ppsps_path)
      click_link 'edit'
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
      find('#ppsp_moa_id').find(:xpath, 'option[2]').select_option
      find('#ppsp_moe_id').find(:xpath, 'option[2]').select_option
      fill_in('ppsp_project_information_attributes_reference', with: "ABRFH78")
      fill_in('ppsp_project_information_attributes_responsible', with: 'Test de responsable')
      fill_in('ppsp_project_information_attributes_phone', with: Faker::PhoneNumber.cell_phone_in_e164)
      fill_in('ppsp_project_information_attributes_email', with: Faker::Internet.email)
      fill_in('ppsp_project_information_attributes_site_manager_attributes_name', with: 'Test de chef de chantier')
      fill_in('ppsp_project_information_attributes_site_manager_attributes_phone', with: Faker::PhoneNumber.cell_phone_in_e164)
      fill_in('ppsp_project_information_attributes_site_manager_attributes_email', with: Faker::Internet.email)
      fill_in("ppsp_project_information_attributes_team_manager_attributes_name", with: "Test de chef d'équipe")
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
 
    scenario 'Click on the Show Page' do
      visit(ppsps_path)
      click_link @ppsp.project_information.reference
      expect(page).to have_current_path(ppsp_path(@ppsp))
    end

    scenario 'Show Page have content' do
      visit(ppsp_path(@ppsp))
      expect(page).to have_content('Plan Particulier de Sécurité et de Protection de la Santé')
    end

    scenario 'Open a new tab when click on PDF' do
      visit(ppsps_path)
      click_link('PDF')
      # Test if there is more than one tab open which would tell us if the PDF link work well opening another tab
      expect(page.driver.browser.window_handles.size).to be > 1
    end

    # scenario 'Change the field when update' do
    #   visit(ppsps_path)
    #   click_link 'edit'
    #   fill_in('ppsp_project_information_attributes_site_manager_attributes_name', with: 'Update chef de chantier')
    #   # Need the reload in order to see the modif
    #   expect{click_button('Mettre à jour le PPSP')}.to change{ @ppsp.reload.project_information.site_manager.name }
    #     .from('Test de chef de chantier')
    #     .to('Update chef de chantier')
    # end

    scenario 'Confirmation message when delete a Ppsp' do
      visit(ppsps_path)
      # Accept the data: { confirm: } in the view 
      msg = accept_confirm { click_link 'x' }
      expect(msg).to eq('Êtes-vous sûr de vouloir supprimer ce document ?')
    end

    scenario 'Delete a Ppsp when click on "x" on the Index page' do
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
