require 'rails_helper'

RSpec.describe "Api::V1::Machine Controller", type: :request, format: :json do
  context 'Unlogged user' do
    it "Can't access the API" do
      get(api_v1_machines_path)
      expect(response).to have_http_status(401)
    end
  end

  context 'Logged user' do
    let(:user) { create(:user) }
    let(:ppsp) { create(:ppsp, user: user) }
    let(:machine) { create(:machine) }
    let(:worker) { create(:worker, company: user.company) }
    let(:conductor) { create(:conductor, ppsp_id: ppsp.id, user_id: user.id, worker_id: worker.id) }

    before do
      login_as(user)
    end

    it "Can access the API" do
      get(api_v1_machines_path(ppsps_id: ''))
      expect(response).to have_http_status(200)
    end

    it 'Body includes the json with the good characteristics' do
      machine
      get(api_v1_machines_path(params: { ppsps_id: ppsp.id, category: machine.machine_category.name }))
      # Don't forget to use an array when there are more than on object
      expect(JSON.parse(response.body)).to include_json(
        [
          id: (be_kind_of Integer),
          caces: (be_kind_of String),
          description: (be_kind_of String),
          image: (be_kind_of String),
          category: {
            name: (be_kind_of String)
          }
        ]
      )
    end

    context 'Machines categories' do
      it 'Body includes the json with the good characteristics' do
        machine
        get(api_v1_machines_categories_path)
        # Don't forget to use an array when there are more than on object
        expect(JSON.parse(response.body)).to include_json(
          [
            category: (be_kind_of String)
          ]
        )
      end
    end
  end
end
