require 'rails_helper'

RSpec.describe "Api::V1::Conductors Controller", type: :request, format: :json do
  context 'Unlogged user' do
    it "Can't access the API" do
      get(api_v1_conductors_path)
      expect(response).to have_http_status(401)
    end
  end

  context 'Logged user' do
    before do
      @user = create(:user)
      login_as(@user)
      @ppsp = create(:ppsp, user: @user)
      @conductor = create_list(:conductor, 3, user: @ppsp.user, ppsp: @ppsp)
    end

    it "Can access the API" do
      get(api_v1_conductors_path(ppsps_id: @ppsp.id))
      expect(response).to have_http_status(200)
    end

    it 'Body includes the json with the good characteristics' do
      get(api_v1_conductors_path(ppsps_id: @ppsp.id))
      # Don't forget to use an array when there are more than on object
      expect(JSON.parse(response.body)).to include_json(
        [
          machine_category: (be_kind_of String),
          machine_caces: (be_kind_of String),
          machine_description: (be_kind_of String),
          worker_first_name: (be_kind_of String),
          worker_last_name: (be_kind_of String)
        ]
      )
    end
  end
end
