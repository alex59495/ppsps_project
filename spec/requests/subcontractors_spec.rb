require 'rails_helper'

RSpec.describe "Subcontractors", type: :request, js: true do
  describe "Logged as User Admin" do
    before do
      user = create(:user_admin)
      @subcontractor = create(:subcontractor)
      @ppsp = create(:ppsp)
      login_as(user)
    end
    let(:params_subcontractor) { attributes_for(:subcontractor) }

    describe "Action create" do
      it { expect { post ppsp_subcontractors_path(@ppsp), params: { subcontractor: params_subcontractor } }.to change(Subcontractor, :count).by(1) }
    end

    describe "Action destroy" do
      it { expect { delete ppsp_subcontractor_path(@ppsp, @subcontractor) }.to change(Subcontractor, :count).by(-1) }
    end
  end
end
