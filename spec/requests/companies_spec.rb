require 'rails_helper'

RSpec.describe "Companies", type: :request do
  context "Normal User" do
    let(:user) { create(:user_uber)}
    before do
      login_as(user)
    end

    it "Can't access the company edit page if you are a normal " do
      expect { get edit_company_path(user.company) }.to raise_error(Pundit::NotAuthorizedError)
    end
  end

  context "Admin User" do
    let(:user) { create(:user_admin) }
    let(:user_other) { create(:user) }


    before do
      login_as(user)
    end

    it "Can't access the company which isn't mine " do
      expect { get edit_company_path(user_other.company) }.to raise_error(Pundit::NotAuthorizedError)
    end

    it "Can modify my company" do
      params = { company: attributes_for(:company) }
      patch company_path(user.company, params: params)
      expect(user.company.reload.name).to eq(params[:company][:name])
      expect(user.company.reload.address).to eq(params[:company][:address])
      expect(user.company.reload.representative).to eq(params[:company][:representative])
    end
  end
end
