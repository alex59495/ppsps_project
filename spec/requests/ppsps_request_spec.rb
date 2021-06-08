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
  let(:ppsp_admin) { create(:ppsp, user: user_admin) }
  let(:ppsp_uber) { create(:ppsp, user: user_uber) }
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

    it "Can access edit page of a ppsp" do
      get edit_ppsp_path(ppsp_uber)
      expect(response).to have_http_status(200)
    end

    it "Can't access an edit page of a ppsp from another one" do
      expect { get edit_ppsp_path(ppsp_admin) }.to raise_error(Pundit::NotAuthorizedError)
    end

    context 'Update steps' do
      let(:updated_responsible) { create(:responsible, company: user_uber.company) }
      let(:updated_site_manager) { create(:site_manager, company: user_uber.company) }
      let(:updated_team_manager) { create(:team_manager, company: user_uber.company) }
      let(:updated_moa) { create(:moa, company: user_uber.company) }
      let(:updated_moe) { create(:moe, company: user_uber.company) }
      let(:updated_regional_committee) { create(:regional_committee, company: user_uber.company) }
      let(:updated_pension_insurance) { create(:pension_insurance, company: user_uber.company) }
      let(:updated_direcct) { create(:direcct, company: user_uber.company) }
      let(:updated_work_medecine) { create(:work_medecine, company: user_uber.company) }
      let(:updated_demining) { create(:demining, company: user_uber.company) }
      let(:updated_sos_hand) { create(:sos_hand, company: user_uber.company) }
      let(:updated_anti_poison) { create(:anti_poison, company: user_uber.company) }
      let(:updated_hospital) { create(:hospital, company: user_uber.company) }

      it "Can update ppsp page at designation step" do
        params_ppsp_updated = { name: 'My updated ppsp', reference: 'Ref Updated', responsible_id: updated_responsible.id, site_manager_id: updated_site_manager.id, team_manager_id: updated_team_manager.id }
        patch ppsp_step_path(ppsp_uber, :ppsp_designation), params: { ppsp: params_ppsp_updated }
        expect(ppsp_uber.reload.attributes.select { |k, _v| Ppsp.form_steps[:ppsp_designation].include?(k.to_sym) }).to eq(
          {
            "name" => 'My updated ppsp',
            "reference" => 'Ref Updated',
            "responsible_id" => updated_responsible.id,
            "site_manager_id" => updated_site_manager.id,
            "team_manager_id" => updated_team_manager.id
          }
        )
      end

      it "Can update ppsp page at master step" do
        params_ppsp_updated = { moe_id: updated_moe.id, moa_id: updated_moa.id }
        patch ppsp_step_path(ppsp_uber, :ppsp_master), params: { ppsp: params_ppsp_updated }
        expect(ppsp_uber.reload.attributes.select { |k, _v| Ppsp.form_steps[:ppsp_master].include?(k.to_sym) }).to eq(
          {
            "moe_id" => updated_moe.id,
            "moa_id" => updated_moa.id
          }
        )
      end

      it "Can update ppsp page at prevention step" do
        params_ppsp_updated = { regional_committee_id: updated_regional_committee.id, pension_insurance_id: updated_pension_insurance.id, direcct_id: updated_direcct.id, work_medecine_id: updated_work_medecine.id}
        patch ppsp_step_path(ppsp_uber, :ppsp_prevention), params: { ppsp: params_ppsp_updated }
        expect(ppsp_uber.reload.attributes.select { |k, _v| Ppsp.form_steps[:ppsp_prevention].include?(k.to_sym) }).to eq(
          {
            "regional_committee_id" => updated_regional_committee.id,
            "pension_insurance_id" => updated_pension_insurance.id,
            "direcct_id" => updated_direcct.id,
            "work_medecine_id" => updated_work_medecine.id
          }
        )
      end

      it "Can update ppsp page at worksite step" do
        params_ppsp_updated = { nature: 'Nature Updated', address: '2 Avenue des Saules, 59160 Lille, France', start_date: Date.today, end_date: Date.today + 1}
        Geocoder.configure(lookup: :test)

        Geocoder::Lookup::Test.add_stub(
          "2 Avenue des Saules, 59160 Lille, France", [
            {
              'latitude' => 50.633333,
              'longitude' => 3.066667,
              'address' => '2 Avenue des Saules, 59160 Lille, France',
              'state' => 'Nord',
              'state_code' => '59',
              'country' => 'France',
              'country_code' => 'FR'
            }
          ]
        )
        patch ppsp_step_path(ppsp_uber, :ppsp_worksite), params: { ppsp: params_ppsp_updated }
        expect(ppsp_uber.reload.attributes.select { |k, _v| Ppsp.form_steps[:ppsp_worksite].include?(k.to_sym) }).to eq(
          {
            "nature" => 'Nature Updated',
            "address" => '2 Avenue des Saules, 59160 Lille, France',
            "start_date" => Date.today,
            "end_date" => Date.today + 1
          }
        )
      end

      it "Can update ppsp page at time_table step" do
        params_ppsp_updated = { timetable_summer: false, timetable_winter: false, timetable_summer_end: nil, timetable_summer_end_friday: nil, timetable_summer_start: nil, timetable_summer_start_friday: nil, timetable_winter_end: nil, timetable_winter_end_friday: nil, timetable_winter_start: nil, timetable_winter_start_friday: nil }
        patch ppsp_step_path(ppsp_uber, :ppsp_time_table), params: { ppsp: params_ppsp_updated }
        expect(ppsp_uber.reload.attributes.select { |k, _v| Ppsp.form_steps[:ppsp_time_table].include?(k.to_sym) }).to eq(
          {
            "timetable_summer" => false,
            "timetable_winter" => false,
            "timetable_summer_end" => nil,
            "timetable_summer_end_friday" => nil,
            "timetable_summer_start" => nil,
            "timetable_summer_start_friday" => nil,
            "timetable_winter_end" => nil,
            "timetable_winter_end_friday" => nil,
            "timetable_winter_start" => nil,
            "timetable_winter_start_friday" => nil
          }
        )
      end

      it "Can update ppsp page at team_number step" do
        params_ppsp_updated = { num_responsible: 13, num_conductor: 11, num_worker: 19 }
        patch ppsp_step_path(ppsp_uber, :ppsp_team_number), params: { ppsp: params_ppsp_updated }
        expect(ppsp_uber.reload.attributes.select { |k, _v| Ppsp.form_steps[:ppsp_team_number].include?(k.to_sym) }).to eq(
          {
            "num_responsible" => 13,
            "num_conductor" => 11,
            "num_worker" => 19
          }
        )
      end

      it "Can update ppsp page at installation step" do
        params_ppsp_updated = { electrical_site: false, water_site: false }
        patch ppsp_step_path(ppsp_uber, :ppsp_installation), params: { ppsp: params_ppsp_updated }
        expect(ppsp_uber.reload.attributes.select { |k, _v| Ppsp.form_steps[:ppsp_installation].include?(k.to_sym) }).to eq(
          {
            "electrical_site" => false,
            "water_site" => false,
            "plan" => false
          }
        )
      end

      it "Can update ppsp page at security step" do
        params_ppsp_updated = { infirmary: true, infirmary_text: 'Updated text', demining_id: updated_demining.id, sos_hand_id: updated_sos_hand.id, anti_poison_id: updated_anti_poison.id, hospital_id: updated_hospital.id }
        patch ppsp_step_path(ppsp_uber, :ppsp_security), params: { ppsp: params_ppsp_updated }
        expect(ppsp_uber.reload.attributes.select { |k, _v| Ppsp.form_steps[:ppsp_security].include?(k.to_sym) }).to eq(
          {
            "infirmary" => true,
            "infirmary_text" => 'Updated text',
            "demining_id" => updated_demining.id,
            "sos_hand_id" => updated_sos_hand.id,
            "anti_poison_id" => updated_anti_poison.id,
            "hospital_id" => updated_hospital.id
          }
        )
      end

      it "Can update ppsp page at annexes step" do
        params_ppsp_updated = { content_secu: 'Updated content secu' }
        patch ppsp_step_path(ppsp_uber, :ppsp_annexes), params: { ppsp: params_ppsp_updated }
        expect(ppsp_uber.reload.attributes.select { |k, _v| Ppsp.form_steps[:ppsp_annexes].include?(k.to_sym) }).to eq(
          {
            "content_secu" => 'Updated content secu'
          }
        )
      end
    end
  end
end
