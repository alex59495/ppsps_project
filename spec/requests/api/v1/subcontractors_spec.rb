require 'rails_helper'

RSpec.describe "Api::V1::Subcontractors Controller", type: :request, format: :json do
  context 'Unlogged user' do
    it "Can't access the API" do
      get(api_v1_list_subcontractors_path)
      expect(response).to have_http_status(401)
    end
  end

  context 'Logged user' do
    before do
      @user = create(:user)
      login_as(@user)
      @subcontractors = create_list(:subcontractor, 3, company: @user.company)
    end

    it "Can access the API" do
      get(api_v1_list_subcontractors_path)
      expect(response).to have_http_status(200)
    end

    it 'Body includes the json with the good characteristics' do
      get(api_v1_list_subcontractors_path)
      # Don't forget to use an array when there are more than on object
      expect(JSON.parse(response.body)).to include_json(
        [
          id: (be_kind_of Integer),
          name: (be_kind_of String),
          work: (be_kind_of String),
          address: (be_kind_of String),
          responsible_name: (be_kind_of String),
          responsible_phone: (be_kind_of String),
          responsible_email: (be_kind_of String)
        ]
      )
    end

    context 'Selected subcontractors' do
      before do
        @ppsp = create(:ppsp, user: @user)
        subcontractors_ids = @subcontractors.map(&:id)
        subcontractors_ids.each do |id|
          create(:selected_subcontractor, ppsp: @ppsp, subcontractor_id: id)
        end
      end

      it 'Body includes the json with the good characteristics' do
        get(api_v1_selected_subcontractors_path, params: { ppsps_id: @ppsp.id })
        # Don't forget to use an array when there are more than on object
        expect(JSON.parse(response.body)).to include_json(
          [
            id: (be_kind_of Integer),
            name: (be_kind_of String),
            work: (be_kind_of String),
            address: (be_kind_of String),
            responsible_name: (be_kind_of String),
            responsible_phone: (be_kind_of String),
            responsible_email: (be_kind_of String)
          ]
        )
      end
    end
  end
end
