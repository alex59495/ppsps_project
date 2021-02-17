require 'rails_helper'

RSpec.feature "Companies", type: :feature, js: true do
  feature 'Company Edit page' do
    before :all do
      company = create(:company)
      @user = create(:user_admin, company: company)
      kit_security_elements = create_list(:kit_security_element, 3, company: company)
    end

    before do
      login_as(@user)
    end

    scenario 'Can add a new kit_security_element' do
      visit(edit_company_path(@user.company))
      count = find('#selected-kit-security').all('li').size
      find('#btn-add-security-kit').click
      page.execute_script("$('#kit_security_element_number').val('3')")
      page.execute_script("$('#kit_security_element_name').val('bandages')")
      expect(find('#selected-kit-security').all('li').size)
      find('#formKitSubmitBtn').click
      sleep 2
      expect(find('#selected-kit-security').all('li').size).to eq(count + 1)
      expect(KitSecurityElement.last.name).to eq('bandages')
    end
  end
end
