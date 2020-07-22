require "application_system_test_case"

class PpspIndicesTest < ApplicationSystemTestCase
  setup do
    # log as the user test before the tests started
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
  end

  test "verify number of old PPSP" do
    visit ppsps_url
    # save_and_open_screenshot
    assert_selector ".card-ppsp", count: Ppsp.where(user: User.find_by(name: 'test1@gmail.com')).count
  end

  test "create a new PPSP" do
    visit ppsps_url
    click_link('Créer un nouveau PPSP')
    assert_selector "input", count: 4
    assert_selector "select", count: 8
  end

  test "link to create a company visible" do
    visit ppsps_url
    find_link('Ajouter une entreprise').visible?
  end
end
