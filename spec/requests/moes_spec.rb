require 'rails_helper'

RSpec.describe "Moes Controller", type: :request do
  context 'Logged as Normal User' do
    before do
      user_uber = create(:user_uber)
      login_as(user_uber)
    end
    
    it "Can't access the moes index" do
      expect{get moes_path}.to raise_error(Pundit::NotAuthorizedError)
    end
  end

  context 'Logged as User Admin' do
    before :all do
      @user = create(:user_admin)
      @moe = create(:moe)
    end

    before do
      login_as(@user)
    end
    
    let(:params_moe) { attributes_for(:moe)}
    let(:params_moe_update) { attributes_for(:moe_update)}

    it "Can access the moe index page" do
      get moes_path
      expect(response).to have_http_status(200)
    end
  
    context 'Action Destroy' do
      let(:destroy_action) { post destroy_mo_path(@moe) }
      it 'Delete 1 instance of moe when using action destroy' do
        expect { destroy_action }.to change(Moe.where(is_destroyed: true), :count).by(1)
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
