require 'rails_helper'

RSpec.describe "Database (in Controller Pages)", type: :request do
  describe "Unlogged User" do
    it "Redirect to sign_in page" do
      get database_path
      expect(response).to redirect_to(new_user_session_path)
    end
  end

  describe "Normal User" do
    let(:user_uber) { create(:user_uber) }

    it "Can't access the database page" do
      login_as(user_uber)
      expect { get database_path }.to raise_error(Pundit::NotAuthorizedError)
    end
  end

  describe 'Admin user' do
    let(:user_admin) { create(:user_admin) }

    it "Can access the database page" do
      login_as(user_admin)
      get database_path
      expect(response).to have_http_status(200)
    end
  end
end
