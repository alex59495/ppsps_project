require 'rails_helper'

RSpec.describe "WorkMedecines Controller", type: :request do
  context 'Logged as User admin' do
    before do
      user = create(:user)
      @work_medecine = create(:work_medecine)
      login_as(user)
    end
    let(:params_work_medecine) { attributes_for(:work_medecine)}
    let(:params_work_medecine_update) { attributes_for(:work_medecine_update)}
  
    context 'Action Destroy' do
      let(:destroy_action) { delete work_medecine_path(@work_medecine) }
      it 'Delete 1 instance of work_medecine when using action destroy' do
        expect { destroy_action }.to change(WorkMedecine, :count).by(-1)
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
      let(:update_action) { patch work_medecine_path(@work_medecine), params: { work_medecine: params_work_medecine_update } }

      it 'Update the attributes of AntiPoison' do
        update_action
        @work_medecine.reload
        expect(@work_medecine.fax).to eq(params_work_medecine_update[:fax])
        expect(@work_medecine.address).to eq(params_work_medecine_update[:address])
        expect(@work_medecine.phone).to eq(params_work_medecine_update[:phone])
      end
    end
  end
  
end
