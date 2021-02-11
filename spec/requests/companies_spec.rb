require 'rails_helper'

RSpec.describe "Companies", type: :request do
  context "Normal User" do
    before do
      @user = create(:user_uber)
      login_as(@user)
    end

    it "Can't access the company edit page if you are a normal " do
      expect { get edit_company_path(@user.company) }.to raise_error(Pundit::NotAuthorizedError)
    end
  end

  context "Admin User" do
    before :all do
      @user = create(:user_admin)
      @user_other = create(:user)
    end

    before do
      login_as(@user)
    end

    it "Can't access the company which isn't mine " do
      expect { get edit_company_path(@user_other.company) }.to raise_error(Pundit::NotAuthorizedError)
    end

    it "Can modify my company" do
      params_company = attributes_for(:company)
      company_path(@user.company, params: params_company)
    end
  end
end
