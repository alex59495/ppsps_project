require 'rails_helper'

RSpec.describe "Profiles", type: :request, js: true do
  context 'Test authorizaton' do
    let(:company) { create(:company_uber) }
    let(:user_1) { create(:user, company: company) }
    let(:user_2) { create(:user, company: company) }
    let(:user_uber) { create(:user_uber) }

    before do
      user_1
      login_as(user_1)
    end

    it "Can't access user profile from another company" do
      user_uber
      expect { get profile_path(user_uber) }.to raise_error(Pundit::NotAuthorizedError)
    end

    it "Can access user profile from the same company" do
      user_2
      get profile_path(user_2)
      expect(response).to have_http_status(200)
    end
  end
end
