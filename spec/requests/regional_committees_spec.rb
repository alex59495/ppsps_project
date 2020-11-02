require 'rails_helper'

RSpec.describe "RegionalCommittees Controller", type: :request do
  context 'Logged as User admin' do
    before do
      user = create(:user)
      @regional_committee = create(:regional_committee)
      login_as(user)
    end
    let(:params_regional_committee) { attributes_for(:regional_committee)}
    let(:params_regional_committee_update) { attributes_for(:regional_committee_update)}
  
    context 'Action Destroy' do
      let(:destroy_action) { delete regional_committee_path(@regional_committee) }
      it 'Delete 1 instance of regional_committee when using action destroy' do
        expect { destroy_action }.to change(RegionalCommittee, :count).by(-1)
      end
  
      it 'Redirect after destroy' do
        destroy_action
        expect(response).to have_http_status(302)
      end
    end

    context 'Action Create' do
      let(:create_action) { post regional_committees_path, params: { regional_committee: params_regional_committee, format: 'js' } }

      it 'Add one instance of RegionalCommittee when using create' do
        expect { create_action }.to change(RegionalCommittee, :count).by(1)
      end
    end

    context 'Action Update' do
      let(:update_action) { patch regional_committee_path(@regional_committee), params: { regional_committee: params_regional_committee_update } }

      it 'Update the attributes of AntiPoison' do
        update_action
        @regional_committee.reload
        expect(@regional_committee.name).to eq(params_regional_committee_update[:name])
        expect(@regional_committee.fax).to eq(params_regional_committee_update[:fax])
        expect(@regional_committee.address).to eq(params_regional_committee_update[:address])
        expect(@regional_committee.phone).to eq(params_regional_committee_update[:phone])
      end
    end
    
  end
  
end
