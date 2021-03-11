require 'rails_helper'

RSpec.describe "Api::V1::Site Installation Controller", type: :request, format: :json do
  context 'Unlogged user' do
    it "Can't access the API" do
      get(api_v1_site_installations_path)
      expect(response).to have_http_status(401)
    end
  end

  context 'Logged user' do
    before do
      @user = create(:user)
      login_as(@user)
    end

    it "Can access the API" do
      get(api_v1_site_installations_path)
      expect(response).to have_http_status(200)
    end

    it 'Body includes the json with the good characteristics' do
      create(:site_installation)
      get(api_v1_site_installations_path)
      # Don't forget to use an array when there are more than on object
      expect(JSON.parse(response.body)).to include_json(
        [
          id: (be_kind_of Integer),
          name: (be_kind_of String),
          mobile: be_in([true, false])
        ]
      )
    end

    context 'Selected site installation' do
      before do
        @ppsp = create(:ppsp, user: @user)
        @selected_installations = create_list(:selected_installation, 3, ppsp: @ppsp)
      end

      it 'Body includes the json with the good characteristics' do
        get(api_v1_selected_site_installations_path(ppsps_id: @ppsp.id))
        # Don't forget to use an array when there are more than on object
        expect(JSON.parse(response.body)).to include_json(
          [
            id: (be_kind_of Integer),
            name: (be_kind_of String),
            mobile: be_in([true, false])
          ]
        )
      end
    end
  end
end
