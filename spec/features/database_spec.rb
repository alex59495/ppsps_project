require 'rails_helper'

def destroy_database
  Ppsp.destroy_all
  Moe.destroy_all
  Moa.destroy_all
  Hospital.destroy_all
  Demining.destroy_all
  ProjectInformation.destroy_all
  RegionalCommittee.destroy_all
  RegionalCommittee.destroy_all
  WorkMedecine.destroy_all
  Risk.destroy_all
  SecurityCoordinator.destroy_all
  SiteInstallation.destroy_all
  SiteManager.destroy_all
  SosHand.destroy_all
  TeamManager.destroy_all
  Direcct.destroy_all
  AntiPoison.destroy_all
  AltitudeWork.destroy_all
  PensionInsurance.destroy_all
  User.destroy_all
  Company.destroy_all
end

RSpec.feature "Databases", type: :feature, js: true do
  feature 'Logged as admin User' do
    let!(:company) { create(:company) }
    let!(:user) { create(:user_admin, company: company) }
    let!(:moa_1) { create(:moa, company: company, name: "Test1") }
    let!(:moe_1) { create(:moe, company: company, name: "Test1") }
    let!(:security_coordinator_1) { create(:security_coordinator, company: company, name: "Test1") }
    let!(:direcct_1) { create(:direcct, company: company, address: "Test1") }
    let!(:pension_insurance_1) { create(:pension_insurance, company: company, address: "Test1") }
    let!(:demining_1) { create(:demining, company: company, name: "Test1") }
    let!(:work_medecine_1) { create(:work_medecine, company: company, address: "Test1") }
    let!(:regional_committee_1) { create(:regional_committee, company: company, name: "Test1") }
    let!(:anti_poison_1) { create(:anti_poison, company: company, name: "Test1") }
    let!(:sos_hand_1) { create(:sos_hand, company: company, name: "Test1") }
    let!(:hospital_1) { create(:hospital, company: company, name: "Test1") }
    let!(:moa_2) { create(:moa, company: company, name: "Test2") }
    let!(:moe_2) { create(:moe, company: company, name: "Test2") }
    let!(:security_coordinator_2) { create(:security_coordinator, company: company, name: "Test2") }
    let!(:direcct_2) { create(:direcct, company: company, address: "Test2") }
    let!(:pension_insurance_2) { create(:pension_insurance, company: company, address: "Test2") }
    let!(:demining_2) { create(:demining, company: company, name: "Test2") }
    let!(:work_medecine_2) { create(:work_medecine, company: company, address: "Test2") }
    let!(:regional_committee_2) { create(:regional_committee, company: company, name: "Test2") }
    let!(:anti_poison_2) { create(:anti_poison, company: company, name: "Test2") }
    let!(:sos_hand_2) { create(:sos_hand, company: company, name: "Test2") }
    let!(:hospital_2) { create(:hospital, company: company, name: "Test2") }

    before do
      login_as user
    end

    scenario "Search bar is working for anti_poison" do
      visit(anti_poisons_path)
      find('.search-db').set("Test1")
      find('.btn-orange-right').click
      expect(page).to have_current_path(anti_poisons_path)
      expect(page).to have_css('.card-database', count: 1)
      destroy_database
    end

    scenario "Search bar is working for demining" do
      visit(deminings_path)
      find('.search-db').set("Test1")
      find('.btn-orange-right').click
      expect(page).to have_current_path(deminings_path)
      expect(page).to have_css('.card-database', count: 1)
      destroy_database
    end

    scenario "Search bar is working for hospital" do
      visit(hospitals_path)
      find('.search-db').set("Test1")
      find('.btn-orange-right').click
      expect(page).to have_current_path(hospitals_path)
      expect(page).to have_css('.card-database', count: 1)
      destroy_database
    end

    scenario "Search bar is working for moa" do
      visit(moas_path)
      find('.search-db').set("Test1")
      find('.btn-orange-right').click
      expect(page).to have_current_path(moas_path)
      expect(page).to have_css('.card-database', count: 1)
      destroy_database
    end

    scenario "Search bar is working for moe" do
      visit(moes_path)
      find('.search-db').set("Test1")
      find('.btn-orange-right').click
      expect(page).to have_current_path(moes_path)
      expect(page).to have_css('.card-database', count: 1)
      destroy_database
    end

    scenario "Search bar is working for pension_insurance" do
      visit(pension_insurances_path)
      find('.search-db').set("Test1")
      find('.btn-orange-right').click
      expect(page).to have_current_path(pension_insurances_path)
      expect(page).to have_css('.card-database', count: 1)
      destroy_database
    end

    scenario "Search bar is working for regional_committee" do
      visit(regional_committees_path)
      find('.search-db').set("Test1")
      find('.btn-orange-right').click
      expect(page).to have_current_path(regional_committees_path)
      expect(page).to have_css('.card-database', count: 1)
      destroy_database
    end

    scenario "Search bar is working for security_coordinator" do
      visit(security_coordinators_path)
      find('.search-db').set("Test1")
      find('.btn-orange-right').click
      expect(page).to have_current_path(security_coordinators_path)
      expect(page).to have_css('.card-database', count: 1)
      destroy_database
    end

    scenario "Search bar is working for work_medecine" do
      visit(work_medecines_path)
      find('.search-db').set("Test1")
      find('.btn-orange-right').click
      expect(page).to have_current_path(work_medecines_path)
      expect(page).to have_css('.card-database', count: 1)
      destroy_database
    end

    scenario "Search bar is working for sos_hand" do
      visit(sos_hands_path)
      find('.search-db').set("Test1")
      find('.btn-orange-right').click
      expect(page).to have_current_path(sos_hands_path)
      expect(page).to have_css('.card-database', count: 1)
      destroy_database
    end

    scenario "Search bar is working for direcct" do
      visit(direccts_path)
      find('.search-db').set("Test1")
      find('.btn-orange-right').click
      expect(page).to have_current_path(direccts_path)
      expect(page).to have_css('.card-database', count: 1)
      destroy_database
    end
  end
end
