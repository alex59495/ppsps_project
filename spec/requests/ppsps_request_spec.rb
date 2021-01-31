require 'rails_helper'

RSpec.describe "Ppsps Controller", type: :request do
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
    let(:params_ppsp) { attributes_for(:ppsp).merge({
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
    }

    context 'Actions when you are the record owner' do
      before do
        user = create(:user)
        @ppsp = create(:ppsp, user: user)
        login_as(user)
      end

      context 'Action Create' do
        let(:create_action) { post ppsps_path, params: { ppsp: params_ppsp } }

        it 'Add one instance of Ppsp when using create' do
          expect { create_action }.to change(Ppsp, :count).by(1)
        end

        it 'Redirect after create' do
          create_action
          expect(response).to have_http_status(302)
        end
      end

      context 'Update Create' do
        let(:update_action) { patch ppsp_path(@ppsp), params: { ppsp: params_ppsp } }

        it 'Update address of PPSP' do
          params_ppsp[:address] = 'Update the address'
          update_action
          expect(@ppsp.reload.address).to eq('Update the address')
        end

        it 'Redirect after update' do
          update_action
          expect(response).to have_http_status(302)
        end
      end
    end

    context "Actions when you're not the record owner" do
      before do
        user = create(:user)
        @ppsp = create(:ppsp)
        login_as(user)
      end

      let(:update_action) { patch ppsp_path(@ppsp), params: { ppsp: params_ppsp } }

      it { expect{ update_action }.to raise_error(Pundit::NotAuthorizedError) }
    end
  end
end
