require 'rails_helper'

RSpec.describe "SecurityCoordinators Controller", type: :request do
  context 'Logged as Normal User' do
    before do
      user_uber = create(:user_uber)
      login_as(user_uber)
    end
    
    it "Can't access the security_coordinators index" do
      expect{get security_coordinators_path}.to raise_error(Pundit::NotAuthorizedError)
    end
  end

  context 'Logged as User Admin' do
    before :all do
      @user = create(:user_admin)
      @security_coordinator = create(:security_coordinator)
    end

    before do
      login_as(@user)
    end

    let(:params_security_coordinator) { attributes_for(:security_coordinator)}
    let(:params_security_coordinator_update) { attributes_for(:security_coordinator_update)}
  
    context 'Action Destroy' do
      let(:destroy_action) { post destroy_security_coordinator_path(@security_coordinator) }
      it 'Delete 1 instance of security_coordinator when using action destroy' do
        expect { destroy_action }.to change(SecurityCoordinator.where(is_destroyed: true), :count).by(1)
      end
  
      it 'Redirect after destroy' do
        destroy_action
        expect(response).to have_http_status(302)
      end
    end

    context 'Action Create' do
      let(:create_action) { post security_coordinators_path, params: { security_coordinator: params_security_coordinator, format: 'js' } }

      it 'Add one instance of SecurityCoordinator when using create' do
        expect { create_action }.to change(SecurityCoordinator, :count).by(1)
      end
    end
    
    context 'Action Update' do
      let(:update_action) { patch security_coordinator_path(@security_coordinator), params: { security_coordinator: params_security_coordinator_update } }

      it 'Update the attributes of SecurityCoordinator' do
        update_action
        @security_coordinator.reload
        expect(@security_coordinator.name).to eq(params_security_coordinator_update[:name])
        expect(@security_coordinator.representative).to eq(params_security_coordinator_update[:representative])
        expect(@security_coordinator.email).to eq(params_security_coordinator_update[:email])
        expect(@security_coordinator.address).to eq(params_security_coordinator_update[:address])
        expect(@security_coordinator.phone).to eq(params_security_coordinator_update[:phone])
      end
    end
  end
  
end
