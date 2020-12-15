require 'rails_helper'

RSpec.describe "Database (in Controller Pages)", type: :request do
  describe "Unlogged User" do
    it "Redirect to sign_in page" do
      get database_path
      expect(response).to redirect_to(new_user_session_path)
    end
  end

  describe "Normal User" do
    before do
      user_uber = create(:user_uber)
      login_as(user_uber)
    end

    it "Can't access the database page" do
      expect{get database_path}.to raise_error(Pundit::NotAuthorizedError)
    end
  end

  describe 'Admin user' do
    before do
      user_admin = create(:user_admin)
      login_as(user_admin)
    end

    it "Can access the database page" do
      get database_path
      expect(response).to have_http_status(200)
    end
  end
end
