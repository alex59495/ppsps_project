require "application_system_test_case"

class PpspNotAdminsTest < ApplicationSystemTestCase
  setup do
    # log as the user test before the tests started
    login_as users(:user_test_2)
  end

  
end
