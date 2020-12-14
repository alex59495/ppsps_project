require 'rails_helper'

RSpec.feature "Users View", type: :feature, js: true  do
  feature "Users View" do
    before do
      company = create(:company_uber)
      @user_uber_1 = create(:user, company: company)
      login_as(@user_uber_1)
      @user_uber_2 = create(:user, company: company)
      @ppsp1 = create(:ppsp, user: @user_uber_1)
      @ppsp2 = create(:ppsp, user: @user_uber_1)
      @ppsp3 = create(:ppsp, user: @user_uber_1)
      @ppsp4 = create(:ppsp, user: @user_uber_2)
      @ppsp5 = create(:ppsp, user: @user_uber_2)
      @user_google = create(:user_google)
    end

    scenario "Can see my PPSPs" do 
      visit profile_path(@user_uber_1)
      expect(page).to have_css('.card-ppsp', count: 3)
    end

    scenario "Can see the profile/PPSPs of a user from the same company" do 
      visit profile_path(@user_uber_2)
      expect(page).to have_css('.card-ppsp', count: 2)
    end
  end
end
