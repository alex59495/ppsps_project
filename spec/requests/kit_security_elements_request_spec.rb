require 'rails_helper'

RSpec.describe "KitSecurityElements", type: :request do
  context "Normal User" do
    before :all do
      @user = create(:user)
    end

    before do
      login_as(@user)
    end

    it "Can't create a kit element security" do
      expect { post kit_security_elements_path(params: { kit_security_element: attributes_for(:kit_security_element) }) }.to raise_error(Pundit::NotAuthorizedError)
    end
  end

  context "Admin User" do
    before :all do
      @user = create(:user_admin)
    end

    before do
      login_as(@user)
    end

    it "Can create a kit element security" do
      expect { post kit_security_elements_path(params: { kit_security_element: attributes_for(:kit_security_element) }, format: 'js') }.to change(KitSecurityElement, :count).by(1)
    end
  end
end
