require 'rails_helper'

RSpec.describe "SosHands Controller", type: :request do
  context 'Logged as Normal User' do
    let(:user_uber) { create(:user_uber) }

    before do
      login_as(user_uber)
    end
    
    it "Can't access the sos_hands index" do
      expect{get sos_hands_path}.to raise_error(Pundit::NotAuthorizedError)
    end
  end

  context 'Logged as User Admin' do
    let(:user) { create(:user_admin) }
    let(:sos_hand) { create(:sos_hand) }
    before do
      login_as(user)
    end
    
    let(:params_sos_hand) { attributes_for(:sos_hand)}
    let(:params_sos_hand_update) { attributes_for(:sos_hand_update)}

    it "Can access the sos_hand index page" do
      get sos_hands_path
      expect(response).to have_http_status(200)
    end

    context 'Action Destroy' do
      let(:destroy_action) { post destroy_sos_hand_path(sos_hand) }
      it 'Delete 1 instance of sos_hand when using action destroy' do
        expect { destroy_action }.to change(SosHand.where(is_destroyed: true), :count).by(1)
      end
  
      it 'Redirect after destroy' do
        destroy_action
        expect(response).to have_http_status(302)
      end
    end

    context 'Action Create' do
      let(:create_action) { post sos_hands_path, params: { sos_hand: params_sos_hand, format: 'js' } }

      it 'Add one instance of SosHand when using create' do
        expect { create_action }.to change(SosHand, :count).by(1)
      end
    end

    context 'Action Update' do
      let(:update_action) { patch sos_hand_path(sos_hand), params: { sos_hand: params_sos_hand_update } }

      it 'Update the attributes of SosHand' do
        update_action
        sos_hand.reload
        expect(sos_hand.name).to eq(params_sos_hand_update[:name])
        expect(sos_hand.address).to eq(params_sos_hand_update[:address])
        expect(sos_hand.phone).to eq(params_sos_hand_update[:phone])
      end
    end
    
  end
  
end
