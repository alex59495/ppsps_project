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

    it "Can't access the pension_insurances index" do
      expect{get pension_insurances_path}.to raise_error(Pundit::NotAuthorizedError)
    end

    it "Can't access the regional_committees index" do
      expect{get regional_committees_path}.to raise_error(Pundit::NotAuthorizedError)
    end

    it "Can't access the deminings index" do
      expect{get deminings_path}.to raise_error(Pundit::NotAuthorizedError)
    end

    it "Can't access the direccts index" do
      expect{get direccts_path}.to raise_error(Pundit::NotAuthorizedError)
    end

    it "Can't access the anti_poisons index" do
      expect{get anti_poisons_path}.to raise_error(Pundit::NotAuthorizedError)
    end

    it "Can't access the moas index" do
      expect{get moas_path}.to raise_error(Pundit::NotAuthorizedError)
    end

    it "Can't access the moes index" do
      expect{get moes_path}.to raise_error(Pundit::NotAuthorizedError)
    end

    it "Can't access the sos_hands index" do
      expect{get sos_hands_path}.to raise_error(Pundit::NotAuthorizedError)
    end

    it "Can't access the work_medecines index" do
      expect{get work_medecines_path}.to raise_error(Pundit::NotAuthorizedError)
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

    it "Can access the hospital index page" do
      get hospitals_path
      expect(response).to have_http_status(200)
    end

    it "Can access the moa index page" do
      get moas_path
      expect(response).to have_http_status(200)
    end

    it "Can access the moe index page" do
      get moes_path
      expect(response).to have_http_status(200)
    end

    it "Can access the pension_insurance index page" do
      get pension_insurances_path
      expect(response).to have_http_status(200)
    end

    it "Can access the regional_committee index page" do
      get regional_committees_path
      expect(response).to have_http_status(200)
    end

    it "Can access the direcct index page" do
      get direccts_path
      expect(response).to have_http_status(200)
    end

    it "Can access the anti_poison index page" do
      get anti_poisons_path
      expect(response).to have_http_status(200)
    end

    it "Can access the sos_hand index page" do
      get sos_hands_path
      expect(response).to have_http_status(200)
    end

    it "Can access the work_medecine index page" do
      get work_medecines_path
      expect(response).to have_http_status(200)
    end

    it "Can access the demining index page" do
      get deminings_path
      expect(response).to have_http_status(200)
    end
  end
end
