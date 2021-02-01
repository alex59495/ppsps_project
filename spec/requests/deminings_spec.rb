require 'rails_helper'

RSpec.describe "Deminings Controller", type: :request do
  context 'Logged as Normal User' do
    before do
      user_uber = create(:user_uber)
      login_as(user_uber)
    end

    it "Can't access the demings index" do
      expect { get deminings_path }.to raise_error(Pundit::NotAuthorizedError)
    end
  end

  context 'Logged as User Admin' do
    before do
      @user = create(:user_admin)
      @demining = create(:demining)
    end

    before do
      login_as(@user)
    end

    let(:params_demining) { attributes_for(:demining) }
    let(:params_demining_update) { attributes_for(:demining_update) }

    it "Can access the demining index page" do
      get deminings_path
      expect(response).to have_http_status(200)
    end

    context 'Action Destroy' do
      let(:destroy_action) { post destroy_demining_path(@demining) }
      it 'Delete 1 instance of demining when using action destroy' do
        expect { destroy_action }.to change(Demining.where(is_destroyed: true), :count).by(1)
      end

      it 'Redirect after destroy' do
        destroy_action
        expect(response).to have_http_status(302)
      end
    end

    context 'Action Create' do
      let(:create_action) { post deminings_path, params: { demining: params_demining, format: 'js' } }

      it 'Add one instance of Demining when using create' do
        expect { create_action }.to change(Demining, :count).by(1)
      end
    end

    context 'Action Update' do
      let(:update_action) { patch demining_path(@demining), params: { demining: params_demining_update } }

      it 'Update the attributes of Demining' do
        update_action
        @demining.reload
        expect(@demining.name).to eq(params_demining_update[:name])
        expect(@demining.address).to eq(params_demining_update[:address])
        expect(@demining.phone).to eq(params_demining_update[:phone])
      end
    end
  end
end
