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
      login_as(user)
    end
    
    it 'Visit Ppsp index' do
      visit(ppsps_path)
      expect(page).to have_current_path(ppsps_path)
    end

    it 'Click on PDF' do
      visit(ppsps_path)
      click_link('PDF')
      expect(page).to has_content('Plan Particulier de Sécurité et de Protection de la Santé')
    end
  end
end
