require 'rails_helper'

RSpec.describe "Api::V1::Conductors Controller", type: :request, format: :json do
  context 'Unlogged user' do
    it "Can't access the API" do
      get(api_v1_conductors_path)
      expect(response).to have_http_status(401)
    end
  end

  context 'Logged user' do
    before :all do
      @user = create(:user)
      @ppsp = create(:ppsp, user: @user)
      @conductors = create_list(:conductor, 3, user: @ppsp.user, ppsp: @ppsp)
    end

    before do
      login_as(@user)
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
          id: (be_kind_of Integer),
          ppsp_id: (be_kind_of Integer),
          machine_category: (be_kind_of String),
          machine_caces: (be_kind_of String),
          machine_description: (be_kind_of String),
          worker_first_name: (be_kind_of String),
          worker_last_name: (be_kind_of String)
        ]
      )
    end

    it "Can create a conductor" do
      worker = create(:worker, company: @user.company)
      machine = create(:machine)
      params_conductor = attributes_for(:conductor).merge(ppsp_id: @ppsp.id, user_id: @user.id, worker_id: worker.id, machine_id: machine.id)
      # We need the machine ID and Worker ID to post
      post(api_v1_create_conductor_path(machine_id: machine.id, worker_id: worker.id), params: { conductor: params_conductor })

      expect(JSON.parse(response.body)).to include_json(
        id: (be_kind_of Integer),
        ppsp_id: (be_kind_of Integer),
        machine_category: (be_kind_of String),
        machine_caces: (be_kind_of String),
        machine_description: (be_kind_of String),
        worker_first_name: (be_kind_of String),
        worker_last_name: (be_kind_of String)
      )
    end

    it "Can destroy a conductor" do
      conductor = create(:conductor, user: @user)
      expect { delete(api_v1_conductor_path(id: conductor.id)) }.to change(Conductor, :count).by(-1)
      expect(response).to have_http_status(204)
    end
  end
end
