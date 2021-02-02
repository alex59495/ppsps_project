require 'rails_helper'

RSpec.describe "AntiPoisons Controller", type: :request do
  context "Normal User" do
    before do
      user_uber = create(:user_uber)
      login_as(user_uber)
    end

    it "Can't access the anti_poisons index" do
      expect { get anti_poisons_path }.to raise_error(Pundit::NotAuthorizedError)
    end
  end

  context 'Logged as User Admin' do
    before :all do
      @user = create(:user_admin)
      @anti_poison = create(:anti_poison)
    end

    before do
      login_as(@user)
    end

    let(:params_anti_poison) { attributes_for(:anti_poison) }
    let(:params_anti_poison_update) { attributes_for(:anti_poison_update) }

    it "Can access the anti_poison index page" do
      get anti_poisons_path
      expect(response).to have_http_status(200)
    end

    context 'Action Destroy' do
      let(:destroy_action) { post destroy_anti_poison_path(@anti_poison) }
      it 'Delete 1 instance of anti_poison when using action destroy' do
        expect { destroy_action }.to change(AntiPoison.where(is_destroyed: true), :count).by(1)
      end

      it 'Redirect after destroy' do
        destroy_action
        expect(response).to have_http_status(302)
      end
    end

    context 'Action Create' do
      let(:create_action) { post anti_poisons_path, params: { anti_poison: params_anti_poison, format: 'js' } }

      it 'Add one instance of AntiPoison when using create' do
        expect { create_action }.to change(AntiPoison, :count).by(1)
      end
    end

    context 'Action Update' do
      let(:update_action) { patch anti_poison_path(@anti_poison), params: { anti_poison: params_anti_poison_update } }

      it 'Update the attributes of AntiPoison' do
        update_action
        @anti_poison.reload
        expect(@anti_poison.name).to eq(params_anti_poison_update[:name])
        expect(@anti_poison.address).to eq(params_anti_poison_update[:address])
        expect(@anti_poison.phone).to eq(params_anti_poison_update[:phone])
      end
    end
  end
end
