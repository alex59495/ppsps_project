require 'rails_helper'

RSpec.feature "Ppsps", type: :feature, js: true do
  context "Unlogged user" do
    it 'Redirect to Sign In page' do
      visit(ppsps_path)
      expect(page).to have_current_path(new_user_session_path)
    end
  end

  context 'Logged as User' do
    before do
      user = create(:user)
      ppsp = create(:ppsp, user: user)
      login_as(user)
    end
    
    it 'Visit Ppsp index' do
      visit(ppsps_path)
      expect(page).to have_current_path(ppsps_path)
    end

    it 'Click on PDF' do
      visit(ppsps_path)
      click_link('PDF')
      # Test if there is more than one tab open which would tell us if the PDF link work well opening another tab
      expect(page.driver.browser.window_handles.size).to be > 1
    end

    it 'Remove a Ppsp' do
      visit(ppsps_path)
      count = Ppsp.all.length
      click_link('x')
      accept_confirm do
        click_link ''
      end
      expect(Ppsp.all.length).to eq(count - 1)
    end
  end
end
