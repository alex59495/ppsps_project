require 'rails_helper'

RSpec.describe "Api::V1::Workers Controller", type: :request, format: :json do
  context 'Unlogged user conductors' do
    it "Can't access the API" do
      get(api_v1_workers_conductors_path)
      expect(response).to have_http_status(401)
    end

    it "Can't access the API lifesavers" do
      get(api_v1_workers_lifesavers_path)
      expect(response).to have_http_status(401)
    end
  end

  context 'Logged user' do
    let(:user) {create(:user) }
    let(:ppsp) { create(:ppsp, user: user) }
    let(:conductors) { create_list(:worker, 3, company: user.company, conductor: true) }
    let(:lifesavers) { create_list(:worker, 3, company: user.company, lifesaver: true) }

    before do
      login_as(user)
    end

    context 'Worker conductors' do
      it "Can access the API" do
        get(api_v1_workers_conductors_path)
        expect(response).to have_http_status(200)
      end

      it 'Body includes the json with the good characteristics' do
        conductors
        get(api_v1_workers_conductors_path)
        # Don't forget to use an array when there are more than on object
        expect(JSON.parse(response.body)).to include_json(
          [
            id: (be_kind_of Integer),
            first_name: (be_kind_of String),
            last_name: (be_kind_of String),
            lifesaver: be_in([true, false]),
            conductor: be_in([true, false])
          ]
        )
      end
    end

    context 'Worker lifesavers' do
      it "Can access the API - lifesaver" do
        get(api_v1_workers_lifesavers_path)
        expect(response).to have_http_status(200)
      end

      it 'Body includes the json with the good characteristics' do
        lifesavers
        get(api_v1_workers_lifesavers_path)
        # Don't forget to use an array when there are more than on object
        expect(JSON.parse(response.body)).to include_json(
          [
            id: (be_kind_of Integer),
            first_name: (be_kind_of String),
            last_name: (be_kind_of String),
            lifesaver: be_in([true, false]),
            conductor: be_in([true, false])
          ]
        )
      end

      context 'Selected lifesavers' do
        before do
          ids_lifesavers = lifesavers.map(&:id)
          ids_lifesavers.each do |id|
            create(:selected_lifesaver, ppsp: ppsp, worker_id: id)
          end
        end

        it 'Body includes the json with the good characteristics' do
          get(api_v1_workers_selected_lifesavers_path(ppsps_id: ppsp.id))
          # Don't forget to use an array when there are more than on object
          expect(JSON.parse(response.body)).to include_json(
            [
              id: (be_kind_of Integer),
              first_name: (be_kind_of String),
              last_name: (be_kind_of String),
              lifesaver: be_in([true, false]),
              conductor: be_in([true, false])
            ]
          )
        end
      end
    end
  end
end
