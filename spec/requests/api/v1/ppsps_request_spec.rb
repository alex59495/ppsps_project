require 'rails_helper'

RSpec.describe "Api::V1::Ppsps Controller", type: :request, format: :json do
  context 'Unlogged user' do
    it "Can't access the API" do
      get(api_v1_ppsps_path)
      expect(response).to have_http_status(401)
    end
  end

  context 'Logged as User Admin' do
    let(:moa) { create(:moa) }
    let(:moe) { create(:moe) }
    let(:security_coordinator) { create(:security_coordinator) }
    let(:project_information) { create(:project_information) }
    let(:site_manager) { create(:site_manager) }
    let(:team_manager) { create(:team_manager) }
    let(:direcct) { create(:moa) }
    let(:regional_committee) { create(:regional_committee) }
    let(:pension_insurance) { create(:pension_insurance) }
    let(:work_medecine) { create(:work_medecine) }
    let(:hospital) { create(:hospital) }
    let(:sos_hand) { create(:sos_hand) }
    let(:anti_poison) { create(:anti_poison) }
    let(:user) { create(:user_admin) }
    let(:demining) { create(:demining) }
    let(:direcct) { create(:direcct) }
    let(:params_ppsp) do
      attributes_for(:ppsp).merge({
                                    security_coordinator_id: security_coordinator.id,
                                    moa_id: moa.id,
                                    moe_id: moe.id,
                                    project_information_attributes: attributes_for(:project_information).merge({
                                                                                                                 site_manager_attributes: attributes_for(:site_manager),
                                                                                                                 team_manager_attributes: attributes_for(:team_manager)
                                                                                                               }),
                                    direcct_id: direcct.id,
                                    regional_committee_id: regional_committee.id,
                                    pension_insurance_id: pension_insurance.id,
                                    work_medecine_id: work_medecine.id,
                                    hospital_id: hospital.id,
                                    sos_hand_id: sos_hand.id,
                                    anti_poison_id: anti_poison.id,
                                    user_id: user.id,
                                    demining_id: demining.id
                                  })
    end

    let(:ppsp) { create(:ppsp, user: user) }

    context 'Actions when you are the record owner' do
      before do
        login_as(user)
      end

      it 'Can access the list of PPSPS of your company' do
        get(api_v1_ppsps_path)
        expect(response).to have_http_status(200)
      end

      it 'Body includes the json with the good characteristics' do
        ppsp
        get(api_v1_ppsps_path)
        # Don't forget to use an array when there are more than on object
        expect(JSON.parse(response.body)).to include_json(
          [
            id: (be_kind_of Integer),
            moa_id: (be_kind_of Integer),
            moe_id: (be_kind_of Integer),
            security_coordinator_id: (be_kind_of Integer),
            regional_committee_id: (be_kind_of Integer),
            pension_insurance_id: (be_kind_of Integer),
            direcct_id: (be_kind_of Integer),
            work_medecine_id: (be_kind_of Integer),
            demining_id: (be_kind_of Integer),
            sos_hand_id: (be_kind_of Integer),
            anti_poison_id: (be_kind_of Integer),
            hospital_id: (be_kind_of Integer),
            project_information: {
              id: (be_kind_of Integer),
              reference: (be_kind_of String),
              name: (be_kind_of String),
              created_at: (be_kind_of String),
              updated_at: (be_kind_of String),
              responsible_id: (be_kind_of Integer),
              team_manager_id: (be_kind_of Integer),
              site_manager_id: (be_kind_of Integer),
              company_id: (be_kind_of Integer)
            },
            worksite: {
              address: (be_kind_of String),
              start_date: (be_kind_of String),
              end_date: (be_kind_of String)
            },
            user: {
              id: (be_kind_of Integer),
              first_name: (be_kind_of String),
              last_name: (be_kind_of String),
              full_name: (be_kind_of String)
            }
          ]
        )
      end

      context 'Action Destroy' do
        it 'Delete 1 instance of Ppsp when using action destroy' do
          ppsp
          expect { delete api_v1_ppsp_path(ppsp) }.to change(Ppsp, :count).by(-1)
        end
      end
    end

    context "Actions when you're not the record owner" do
      before do
        login_as(user)
      end

      it "Can't delete ppsp which isn't from this user" do
        ppsp = create(:ppsp)
        expect { delete api_v1_ppsp_path(ppsp) }.to change(Ppsp, :count).by(0)
      end
    end
  end
end
