require 'rails_helper'

RSpec.describe "PensionInsurances Controller", type: :request do
  context 'Logged as User Admin' do
    before do
      user = create(:user_admin)
      @pension_insurance = create(:pension_insurance)
      login_as(user)
    end
    let(:params_pension_insurance) { attributes_for(:pension_insurance)}
    let(:params_pension_insurance_update) { attributes_for(:pension_insurance_update)}
  
    context 'Action Destroy' do
      let(:destroy_action) { delete pension_insurance_path(@pension_insurance) }
      it 'Delete 1 instance of pension_insurance when using action destroy' do
        expect { destroy_action }.to change(PensionInsurance, :count).by(-1)
      end
  
      it 'Redirect after destroy' do
        destroy_action
        expect(response).to have_http_status(302)
      end
    end

    context 'Action Create' do
      let(:create_action) { post pension_insurances_path, params: { pension_insurance: params_pension_insurance, format: 'js' } }

      it 'Add one instance of PensionInsurance when using create' do
        expect { create_action }.to change(PensionInsurance, :count).by(1)
      end
    end

    context 'Action Update' do
      let(:update_action) { patch pension_insurance_path(@pension_insurance), params: { pension_insurance: params_pension_insurance_update } }

      it 'Update the attributes of AntiPoison' do
        update_action
        @pension_insurance.reload
        expect(@pension_insurance.fax).to eq(params_pension_insurance_update[:fax])
        expect(@pension_insurance.address).to eq(params_pension_insurance_update[:address])
        expect(@pension_insurance.phone).to eq(params_pension_insurance_update[:phone])
      end
    end
    
  end
  
end
