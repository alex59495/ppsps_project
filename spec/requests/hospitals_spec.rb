require 'rails_helper'

RSpec.describe "Hospitals Controller", type: :request do
  context 'Logged as Normal User' do
    let(:user_uber) { create(:user_uber) }
    before do
      login_as(user_uber)
    end
    
    it "Can't access the hospitals index" do
      expect{get hospitals_path}.to raise_error(Pundit::NotAuthorizedError)
    end
  end

  context 'Logged as User Admin' do
    let(:user) { create(:user_admin) }
    let(:hospital) { create(:hospital) }
    before do
      login_as(user)
    end
    
    let(:params_hospital) { attributes_for(:hospital)}
    let(:params_hospital_update) { attributes_for(:hospital_update)}

    it "Can access the hospital index page" do
      get hospitals_path
      expect(response).to have_http_status(200)
    end
  
    context 'Action Destroy' do
      let(:destroy_action) { post destroy_hospital_path(hospital) }
      it 'Delete 1 instance of hospital when using action destroy' do
        expect { destroy_action }.to change(Hospital.where(is_destroyed: true), :count).by(1)
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
      let(:update_action) { patch hospital_path(hospital), params: { hospital: params_hospital_update } }

      it 'Update the attributes of Hospital' do
        update_action
        hospital.reload
        expect(hospital.name).to eq(params_hospital_update[:name])
        expect(hospital.address).to eq(params_hospital_update[:address])
        expect(hospital.phone).to eq(params_hospital_update[:phone])
      end
    end
    
  end
  
end
