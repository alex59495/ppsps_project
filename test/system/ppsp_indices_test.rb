require "application_system_test_case"

class PpspIndicesTest < ApplicationSystemTestCase
  setup do
    login_as users(:user_test_1)
  end

  test "redirect if not logged" do
    logout :user
    visit ppsps_url
    assert_selector "h2", text: "Log in"
  end


  test "visiting the index" do
    visit ppsps_url
    assert_selector "h1", text: "Mes anciens PPSP"
    save_and_open_screenshot
  end

  test "verify number of old PPSP" do
    visit ppsps_url
    # save_and_open_screenshot
    assert_selector ".card-ppsp", count: Ppsp.where(user: User.first).count
  end

  # test "create a new PPSP" do 
  # end
end
