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

    it 'Click on the Show Page' do
      visit(ppsps_path)
      click_link 'Voir les infos'
      expect(page).to have_current_path(ppsp_path(@ppsp))
    end

    it 'Show Page' do
      visit(ppsp_path(@ppsp))
      expect(page).to have_content('Plan Particulier de Sécurité et de Protection de la Santé')
    end

    it 'Click on PDF and open a new page' do
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
      accept_confirm do
        click_link 'x'
      end
      # Had to refresh the page so that the modification is Ok
      visit current_path
      expect(Ppsp.count).to eq(count - 1)
    end
  end
end
