require 'rails_helper'

RSpec.describe "Api::V1::Risks Controller", type: :request, format: :json do
  context 'Unlogged user' do
    it "Can't access the API" do
      get(api_v1_risks_path)
      expect(response).to have_http_status(401)
    end
  end

  let(:user) { create(:user) }

  context 'Logged user' do
    before do
      login_as(user)
    end

    it "Can access the API" do
      get(api_v1_risks_path)
      expect(response).to have_http_status(200)
    end

    it 'Body includes the json with the good characteristics' do
      create(:risk)
      get(api_v1_risks_path)
      # Don't forget to use an array when there are more than on object
      expect(JSON.parse(response.body)).to include_json(
        [
          id: (be_kind_of Integer),
          name: (be_kind_of String),
          categorie: (be_kind_of String)
        ]
      )
    end

    context 'Selected Risks' do
      before do
        @ppsp = create(:ppsp, user: user)
        @selected_risks = create_list(:selected_risk, 3, ppsp: @ppsp)
      end

      it 'Body includes the json with the good characteristics' do
        get(api_v1_selected_risks_path(ppsps_id: @ppsp.id))
        # Don't forget to use an array when there are more than on object
        expect(JSON.parse(response.body)).to include_json(
          [
            id: (be_kind_of Integer),
            name: (be_kind_of String),
            categorie: (be_kind_of String)
          ]
        )
      end
    end
  end
end
