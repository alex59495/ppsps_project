require 'rails_helper'

RSpec.feature "Users View", type: :feature, js: true do
  feature "Users View" do
    before do
      company = create(:company_uber)
      @user_uber1 = create(:user, company: company)
      @user_uber2 = create(:user, company: company)
      @ppsps1 = create_list(:ppsp, 3, user: @user_uber1)
      @ppsps2 = create_list(:ppsp, 2, user: @user_uber2)
    end

    before do
      login_as(@user_uber1)
    end

    scenario "Can see my PPSPs" do
      visit profile_path(@user_uber1)
      expect(page).to have_css('.card-ppsp', count: @ppsps1.count)
    end

    scenario "Can see the profile/PPSPs of a user from the same company" do
      visit profile_path(@user_uber2)
      expect(page).to have_css('.card-ppsp', count: @ppsps2.count)
    end
  end
end
