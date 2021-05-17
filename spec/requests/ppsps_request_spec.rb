require 'rails_helper'

RSpec.describe "Ppsps Controller", type: :request do
  # let(:user) { create(:user_admin) }

  # context 'Logged as User Admin' do
  #   let(:moa) { create(:moa) }
  #   let(:moe) { create(:moe) }
  #   let(:security_coordinator) { create(:security_coordinator) }
  #   let(:site_manager) { create(:site_manager) }
  #   let(:team_manager) { create(:team_manager) }
  #   let(:direcct) { create(:moa) }
  #   let(:regional_committee) { create(:regional_committee) }
  #   let(:pension_insurance) { create(:pension_insurance) }
  #   let(:work_medecine) { create(:work_medecine) }
  #   let(:hospital) { create(:hospital) }
  #   let(:sos_hand) { create(:sos_hand) }
  #   let(:anti_poison) { create(:anti_poison) }
  #   let(:demining) { create(:demining) }
  #   let(:direcct) { create(:direcct) }
  #   let(:responsible) { create(:responsible) }
  #   let(:site_manager) { create(:site_manager) }
  #   let(:team_manager) { create(:team_manager) }
  #   let(:responsible) { create(:responsible) }
  #   let(:site_manager) { create(:site_manager) }
  #   let(:team_manager) { create(:team_manager) }
  #   let(:params_ppsp) do
  #     attributes_for(:ppsp).merge({
  #                                   security_coordinator_id: security_coordinator.id,
  #                                   moa_id: moa.id,
  #                                   moe_id: moe.id,
  #                                   direcct_id: direcct.id,
  #                                   regional_committee_id: regional_committee.id,
  #                                   pension_insurance_id: pension_insurance.id,
  #                                   work_medecine_id: work_medecine.id,
  #                                   hospital_id: hospital.id,
  #                                   sos_hand_id: sos_hand.id,
  #                                   anti_poison_id: anti_poison.id,
  #                                   user_id: user.id,
  #                                   demining_id: demining.id
  #                                 })
  #   end

  #   context 'Actions when you are the record owner' do
  #     let(:ppsp) { create(:ppsp, user: user) }

  #     before do
  #       login_as(user)
  #     end

  #     context 'Action Create' do
  #       let(:create_action) { post ppsps_path, params: { ppsp: params_ppsp } }

  #       it 'Add one instance of Ppsp when using create' do
  #         expect { create_action }.to change(Ppsp, :count).by(1)
  #       end

  #       it 'Redirect after create' do
  #         create_action
  #         expect(response).to have_http_status(302)
  #       end
  #     end

  #     context 'Action Update' do
  #       let(:update_action) { patch ppsp_path(ppsp), params: { ppsp: params_ppsp } }

  #       it 'Update address of PPSP' do
  #         params_ppsp[:nature] = 'Update the nature'
  #         update_action
  #         expect(ppsp.reload.worksite.nature).to eq('Update the nature')
  #       end

  #       it 'Redirect after update' do
  #         update_action
  #         expect(response).to have_http_status(302)
  #       end
  #     end
  #   end

  #   context "Actions when you're not the record owner" do
  #     let(:ppsp) { create(:ppsp) }
  #     let(:user) { create(:user) }

  #     before do
  #       login_as(user)
  #     end

  #     it "Can't update PPSP" do
  #       expect { patch step_ppsp_path(ppsp, "ppsp_designation"), params: { ppsp: params_ppsp } }.to raise_error(Pundit::NotAuthorizedError)
  #     end
  #   end
  # end

  let(:user_admin) { create(:user_admin) }
  let(:user_uber) { create(:user_uber) }
  let(:ppsp) { create(:ppsp, user: user_admin) }
  let(:ppsp_designation) { create(:ppsp_designation, user: user_uber) }
  let(:ppsp_master) { create(:ppsp_master, user: user_uber) }
  let(:ppsp_prevention) { create(:ppsp_prevention, user: user_uber) }
  let(:ppsp_worksite) { create(:ppsp_worksite, user: user_uber) }
  let(:ppsp_time_table) { create(:ppsp_time_table, user: user_uber) }
  let(:ppsp_team_number) { create(:ppsp_team_number, user: user_uber) }
  let(:ppsp_installation) { create(:ppsp_installation, user: user_uber) }
  let(:ppsp_security) { create(:ppsp_security, user: user_uber) }

  context 'As an Unlogged User' do
    it "Can't acces the index page (Redirection)" do
      get ppsps_path
      expect(response).to have_http_status(302)
    end
  end

  context 'As a logged User' do
    before do
      login_as(user_uber)
    end

    it "Can access a new Ppsp page" do
      get new_ppsp_path
      expect(response).to redirect_to("/ppsps/#{Ppsp.last.id}/steps/ppsp_designation")
    end
  end
end
