require 'rails_helper'

RSpec.describe "Direccts Controller", type: :request do
  context 'Logged as Normal User' do
    let(:user_uber) { create(:user_uber) }

    before do
      login_as(user_uber)
    end
    
    it "Can't access the direccts index" do
      expect{get direccts_path}.to raise_error(Pundit::NotAuthorizedError)
    end
  end

  context 'Logged as User Admin' do
    let(:user) { create(:user_admin) }
    let(:direcct) { create(:direcct) }

    before do
      login_as(user)
    end
    
    let(:params_direcct) { attributes_for(:direcct)}
    let(:params_direcct_update) { attributes_for(:direcct_update)}

    it "Can access the direcct index page" do
      get direccts_path
      expect(response).to have_http_status(200)
    end
  
    context 'Action Destroy' do
      let(:destroy_action) { post destroy_direcct_path(direcct) }
      it 'Delete 1 instance of direcct when using action destroy' do
        expect { destroy_action }.to change(Direcct.where(is_destroyed: true), :count).by(1)
      end
  
      it 'Redirect after destroy' do
        destroy_action
        expect(response).to have_http_status(302)
      end
    end

    context 'Action Create' do
      let(:create_action) { post direccts_path, params: { direcct: params_direcct, format: 'js' } }

      it 'Add one instance of Direcct when using create' do
        expect { create_action }.to change(Direcct, :count).by(1)
      end
    end

    context 'Action Update' do
      let(:update_action) { patch direcct_path(direcct), params: { direcct: params_direcct_update } }

      it 'Update the attributes of Direcct' do
        update_action
        direcct.reload
        expect(direcct.fax).to eq(params_direcct_update[:fax])
        expect(direcct.address).to eq(params_direcct_update[:address])
        expect(direcct.phone).to eq(params_direcct_update[:phone])
      end
    end
    
  end
  
end
