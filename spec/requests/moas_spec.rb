require 'rails_helper'

RSpec.describe "Moas Controller", type: :request do
  context 'Logged as User admin' do
    before do
      user = create(:user)
      @moa = create(:moa)
      login_as(user)
    end
    let(:params_moa) { attributes_for(:moa)}
    let(:params_moa_update) { attributes_for(:moa_update)}


  
    context 'Action Destroy' do
      let(:destroy_action) { delete moa_path(@moa) }
      it 'Delete 1 instance of moa when using action destroy' do
        expect { destroy_action }.to change(Moa, :count).by(-1)
      end
  
      it 'Redirect after destroy' do
        destroy_action
        expect(response).to have_http_status(302)
      end
    end

    context 'Action Create' do
      let(:create_action) { post moas_path, params: { moa: params_moa, format: 'js' } }

      it 'Add one instance of Moa when using create' do
        expect { create_action }.to change(Moa, :count).by(1)
      end
    end

    context 'Action Update' do
      let(:update_action) { patch moa_path(@moa), params: { moa: params_moa_update } }

      it 'Update the attributes of Moa' do
        update_action
        @moa.reload
        expect(@moa.name).to eq(params_moa_update[:name])
        expect(@moa.address).to eq(params_moa_update[:address])
        expect(@moa.phone).to eq(params_moa_update[:phone])
        expect(@moa.representative).to eq(params_moa_update[:representative])
        expect(@moa.email).to eq(params_moa_update[:email])
      end
    end
    
  end
  
end
