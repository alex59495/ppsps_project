require 'rails_helper'

RSpec.describe "Moes Controller", type: :request do
  context 'Logged as User admin' do
    before do
      user = create(:user)
      @moe = create(:moe)
      login_as(user)
    end
    let(:params_moe) { attributes_for(:moe)}
    let(:params_moe_update) { attributes_for(:moe_update)}


  
    context 'Action Destroy' do
      let(:destroy_action) { delete mo_path(@moe) }
      it 'Delete 1 instance of moe when using action destroy' do
        expect { destroy_action }.to change(Moe, :count).by(-1)
      end
  
      it 'Redirect after destroy' do
        destroy_action
        expect(response).to have_http_status(302)
      end
    end

    context 'Action Create' do
      let(:create_action) { post moes_path, params: { moe: params_moe, format: 'js' } }

      it 'Add one instance of Moe when using create' do
        expect { create_action }.to change(Moe, :count).by(1)
      end
    end

    context 'Action Update' do
      let(:update_action) { patch mo_path(@moe), params: { moe: params_moe_update } }

      it 'Update the attributes of Moe' do
        update_action
        @moe.reload
        expect(@moe.name).to eq(params_moe_update[:name])
        expect(@moe.address).to eq(params_moe_update[:address])
        expect(@moe.phone).to eq(params_moe_update[:phone])
        expect(@moe.representative).to eq(params_moe_update[:representative])
        expect(@moe.email).to eq(params_moe_update[:email])
      end
    end
    
  end
  
end
