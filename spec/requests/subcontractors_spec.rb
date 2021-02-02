require 'rails_helper'

RSpec.describe "Subcontractors Controller", type: :request do
  context 'Logged as Normal User' do
    before do
      user_uber = create(:user_uber)
      login_as(user_uber)
    end

    it "Can't access the subcontractors index" do
      expect { get subcontractors_path }.to raise_error(Pundit::NotAuthorizedError)
    end
  end

  context 'Logged as User Admin' do
    before :all do
      @user = create(:user_admin)
      @subcontractor = create(:subcontractor)
    end

    before do
      login_as(@user)
    end

    let(:params_subcontractor) { attributes_for(:subcontractor) }
    let(:params_subcontractor_update) { attributes_for(:subcontractor_update) }

    it "Can access the subcontractor index page" do
      get subcontractors_path
      expect(response).to have_http_status(200)
    end

    context 'Action Destroy' do
      let(:destroy_action) { post destroy_subcontractor_path(@subcontractor) }
      it 'Delete 1 instance of subcontractor when using action destroy' do
        expect { destroy_action }.to change(Subcontractor.where(is_destroyed: true), :count).by(1)
      end

      it 'Redirect after destroy' do
        destroy_action
        expect(response).to have_http_status(302)
      end
    end

    context 'Action Create' do
      let(:create_action) { post subcontractors_path, params: { subcontractor: params_subcontractor, format: 'js' } }

      it 'Add one instance of Subcontractor when using create' do
        expect { create_action }.to change(Subcontractor, :count).by(1)
      end
    end

    context 'Action Update' do
      let(:update_action) { patch subcontractor_path(@subcontractor), params: { subcontractor: params_subcontractor_update } }

      it 'Update the attributes of Subcontractor' do
        update_action
        @subcontractor.reload
        expect(@subcontractor.name).to eq(params_subcontractor_update[:name])
        expect(@subcontractor.work).to eq(params_subcontractor_update[:work])
        expect(@subcontractor.address).to eq(params_subcontractor_update[:address])
        expect(@subcontractor.responsible_name).to eq(params_subcontractor_update[:responsible_name])
        expect(@subcontractor.responsible_email).to eq(params_subcontractor_update[:responsible_email])
        expect(@subcontractor.responsible_phone).to eq(params_subcontractor_update[:responsible_phone])
      end
    end
  end
end
