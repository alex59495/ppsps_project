require 'rails_helper'

RSpec.describe "Hospitals Controller", type: :request do
  context 'Logged as User admin' do
    before do
      user = create(:user)
      @hospital = create(:hospital)
      login_as(user)
    end
    let(:params_hospital) { attributes_for(:hospital)}
    let(:params_hospital_update) { attributes_for(:hospital_update)}


  
    context 'Action Destroy' do
      let(:destroy_action) { delete hospital_path(@hospital) }
      it 'Delete 1 instance of hospital when using action destroy' do
        expect { destroy_action }.to change(Hospital, :count).by(-1)
      end
  
      it 'Redirect after destroy' do
        destroy_action
        expect(response).to have_http_status(302)
      end
    end

    context 'Action Create' do
      let(:create_action) { post hospitals_path, params: { hospital: params_hospital, format: 'js' } }

      it 'Add one instance of Hospital when using create' do
        expect { create_action }.to change(Hospital, :count).by(1)
      end
    end

    context 'Action Update' do
      let(:update_action) { patch hospital_path(@hospital), params: { hospital: params_hospital_update } }

      it 'Update the attributes of Hospital' do
        update_action
        @hospital.reload
        expect(@hospital.name).to eq(params_hospital_update[:name])
        expect(@hospital.address).to eq(params_hospital_update[:address])
        expect(@hospital.phone).to eq(params_hospital_update[:phone])
      end
    end
    
  end
  
end
