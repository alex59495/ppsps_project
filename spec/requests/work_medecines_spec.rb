require 'rails_helper'

RSpec.describe "WorkMedecines Controller", type: :request do
  context 'Logged as Normal User' do
    let(:user_uber) { create(:user_uber) }

    before do
      login_as(user_uber)
    end

    it "Can't access the work_medecines index" do
      expect { get work_medecines_path }.to raise_error(Pundit::NotAuthorizedError)
    end
  end

  context 'Logged as User Admin' do
    let(:user) { create(:user_admin) }
    let(:work_medecine) { create(:work_medecine) }
    before do
      login_as(user)
    end

    let(:params_work_medecine) { attributes_for(:work_medecine) }
    let(:params_work_medecine_update) { attributes_for(:work_medecine_update) }

    it "Can access the work_medecine index page" do
      get work_medecines_path
      expect(response).to have_http_status(200)
    end

    context 'Action Destroy' do
      let(:destroy_action) { post destroy_work_medecine_path(work_medecine) }
      it 'Delete 1 instance of work_medecine when using action destroy' do
        expect { destroy_action }.to change(WorkMedecine.where(is_destroyed: true), :count).by(1)
      end

      it 'Redirect after destroy' do
        destroy_action
        expect(response).to have_http_status(302)
      end
    end

    context 'Action Create' do
      let(:create_action) { post work_medecines_path, params: { work_medecine: params_work_medecine, format: 'js' } }

      it 'Add one instance of WorkMedecine when using create' do
        expect { create_action }.to change(WorkMedecine, :count).by(1)
      end
    end

    context 'Action Update' do
      let(:update_action) { patch work_medecine_path(work_medecine), params: { work_medecine: params_work_medecine_update } }

      it 'Update the attributes of WorkMedecine' do
        update_action
        work_medecine.reload
        expect(work_medecine.fax).to eq(params_work_medecine_update[:fax])
        expect(work_medecine.address).to eq(params_work_medecine_update[:address])
        expect(work_medecine.phone).to eq(params_work_medecine_update[:phone])
      end
    end
  end
end
