require 'rails_helper'

RSpec.feature "Databases", type: :feature, js: true do
  feature 'Logged as admin User' do
    before :all do
      company = create(:company)
      @user = create(:user_admin, company: company)
      moa_1 = create(:moa, company: company, name: "Test1")
      moe_1 = create(:moe, company: company, name: "Test1")
      security_coordinator_1 = create(:security_coordinator, company: company, name: "Test1")
      direcct_1 = create(:direcct, company: company, address: "Test1")
      pension_insurance_1 = create(:pension_insurance, company: company, address: "Test1")
      demining_1 = create(:demining, company: company, name: "Test1")
      work_medecine_1 = create(:work_medecine, company: company, address: "Test1")
      regional_committee_1 = create(:regional_committee, company: company, name: "Test1")
      anti_poison_1 = create(:anti_poison, company: company, name: "Test1")
      sos_hand_1 = create(:sos_hand, company: company, name: "Test1")
      hospital_1 = create(:hospital, company: company, name: "Test1")
      moa_2 = create(:moa, company: company, name: "Test2")
      moe_2 = create(:moe, company: company, name: "Test2")
      security_coordinator_2 = create(:security_coordinator, company: company, name: "Test2")
      direcct_2 = create(:direcct, company: company, address: "Test2")
      pension_insurance_2 = create(:pension_insurance, company: company, address: "Test2")
      demining_2 = create(:demining, company: company, name: "Test2")
      work_medecine_2 = create(:work_medecine, company: company, address: "Test2")
      regional_committee_2 = create(:regional_committee, company: company, name: "Test2")
      anti_poison_2 = create(:anti_poison, company: company, name: "Test2")
      sos_hand_2 = create(:sos_hand, company: company, name: "Test2")
      hospital_2 = create(:hospital, company: company, name: "Test2")
    end

    before do
      login_as(@user)
    end

    scenario "Can see the addition of moa live (AJAX)" do
      visit(moas_path)
      count = page.all('.card-bdd').count
      find('.btn-blue').click
      page.execute_script("$('#moa_name').val('Test moa')")
      page.execute_script("$('#moa_address').val('Test moa')")
      page.execute_script("$('#moa_representative').val('Test moa')")
      page.execute_script("$('#moa_email').val('test_moa@gmail.com')")
      page.execute_script("$('#moa_phone').val('0600000000')")
      find('#MoaBtn').click
      expect(page).to have_css('.card-bdd', count: count + 1)
    end

    scenario "Can see the addition of moe live (AJAX)" do
      visit(moes_path)
      count = page.all('.card-bdd').count
      find('.btn-blue').click
      page.execute_script("$('#moe_name').val('Test moe')")
      page.execute_script("$('#moe_address').val('Test moe')")
      page.execute_script("$('#moe_representative').val('Test moe')")
      page.execute_script("$('#moe_email').val('test_moe@gmail.com')")
      page.execute_script("$('#moe_phone').val('0600000000')")
      find('#MoeBtn').click
      expect(page).to have_css('.card-bdd', count: count + 1)
    end

    scenario "Can see the addition of anti_poison live (AJAX)" do
      visit(anti_poisons_path)
      count = page.all('.card-bdd').count
      find('.btn-blue').click
      page.execute_script("$('#anti_poison_name').val('Test anti_poison')")
      page.execute_script("$('#anti_poison_address').val('Test anti_poison')")
      page.execute_script("$('#anti_poison_phone').val('0600000000')")
      find('#AntiPoisonBtn').click
      expect(page).to have_css('.card-bdd', count: count + 1)
    end

    scenario "Can see the addition of demining live (AJAX)" do
      visit(deminings_path)
      count = page.all('.card-bdd').count
      find('.btn-blue').click
      page.execute_script("$('#demining_name').val('Test demining')")
      page.execute_script("$('#demining_address').val('Test demining')")
      page.execute_script("$('#demining_phone').val('0600000000')")
      find('#DeminingBtn').click
      expect(page).to have_css('.card-bdd', count: count + 1)
    end

    scenario "Can see the addition of sos_hand live (AJAX)" do
      visit(sos_hands_path)
      count = page.all('.card-bdd').count
      find('.btn-blue').click
      page.execute_script("$('#sos_hand_name').val('Test sos_hand')")
      page.execute_script("$('#sos_hand_address').val('Test sos_hand')")
      page.execute_script("$('#sos_hand_phone').val('0600000000')")
      find('#SosBtn').click
      expect(page).to have_css('.card-bdd', count: count + 1)
    end

    scenario "Can see the addition of hospital live (AJAX)" do
      visit(hospitals_path)
      count = page.all('.card-bdd').count
      find('.btn-blue').click
      page.execute_script("$('#hospital_name').val('Test hospital')")
      page.execute_script("$('#hospital_address').val('Test hospital')")
      page.execute_script("$('#hospital_phone').val('0600000000')")
      find('#HospitalBtn').click
      expect(page).to have_css('.card-bdd', count: count + 1)
    end

    scenario "Can see the addition of direcct live (AJAX)" do
      visit(direccts_path)
      count = page.all('.card-bdd').count
      find('.btn-blue').click
      page.execute_script("$('#direcct_fax').val('0600000000')")
      page.execute_script("$('#direcct_address').val('Test direcct')")
      page.execute_script("$('#direcct_phone').val('0600000000')")
      find('#DirecctBtn').click
      expect(page).to have_css('.card-bdd', count: count + 1)
    end

    scenario "Can see the addition of regional_committee live (AJAX)" do
      visit(regional_committees_path)
      count = page.all('.card-bdd').count
      find('.btn-blue').click
      page.execute_script("$('#regional_committee_name').val('Test regional_committee')")
      page.execute_script("$('#regional_committee_fax').val('0600000000')")
      page.execute_script("$('#regional_committee_address').val('Test regional_committee')")
      page.execute_script("$('#regional_committee_phone').val('0600000000')")
      find('#RegionalBtn').click
      expect(page).to have_css('.card-bdd', count: count + 1)
    end

    scenario "Can see the addition of pension_insurance live (AJAX)" do
      visit(pension_insurances_path)
      count = page.all('.card-bdd').count
      find('.btn-blue').click
      page.execute_script("$('#pension_insurance_fax').val('0600000000')")
      page.execute_script("$('#pension_insurance_address').val('Test pension_insurance')")
      page.execute_script("$('#pension_insurance_phone').val('0600000000')")
      find('#PensionBtn').click
      expect(page).to have_css('.card-bdd', count: count + 1)
    end

    scenario "Can see the addition of work_medecine live (AJAX)" do
      visit(work_medecines_path)
      count = page.all('.card-bdd').count
      find('.btn-blue').click
      page.execute_script("$('#work_medecine_fax').val('0600000000')")
      page.execute_script("$('#work_medecine_address').val('Test work_medecine')")
      page.execute_script("$('#work_medecine_phone').val('0600000000')")
      find('#WorkMedecineBtn').click
      expect(page).to have_css('.card-bdd', count: count + 1)
    end

    scenario "Can see the addition of security_coordinator live (AJAX)" do
      visit(security_coordinators_path)
      count = page.all('.card-bdd').count
      find('.btn-blue').click
      page.execute_script("$('#security_coordinator_name').val('Test security_coordinator')")
      page.execute_script("$('#security_coordinator_address').val('Test security_coordinator')")
      page.execute_script("$('#security_coordinator_representative').val('Test security_coordinator')")
      page.execute_script("$('#security_coordinator_email').val('test_representative@gmail.com')")
      page.execute_script("$('#security_coordinator_phone').val('0600000000')")
      find('#SecurityBtn').click
      expect(page).to have_css('.card-bdd', count: count + 1)
    end

    scenario "Can see the addition of subcontractor live (AJAX)" do
      visit(subcontractors_path)
      count = page.all('.card-bdd').count
      find('.btn-blue').click
      page.execute_script("$('#subcontractor_name').val('Test subcontractor')")
      page.execute_script("$('#subcontractor_address').val('Test subcontractor')")
      page.execute_script("$('#subcontractor_work').val('Test subcontractor')")
      page.execute_script("$('#subcontractor_responsible_name').val('Test responsible')")
      page.execute_script("$('#subcontractor_responsible_email').val('test_responsible@gmail.com')")
      page.execute_script("$('#subcontractor_responsible_phone').val('0600000000')")
      find('#SubcontractorBtn').click
      sleep 3
      expect(page).to have_css('.card-bdd', count: count + 1)
    end

    scenario "Rerender MOA form when not filling right" do
      visit(moas_path)
      find('.btn-blue').click
      fill_in('moa_name', with: 'Test Moa')
      fill_in('moa_representative', with: 'Test Moa')
      fill_in('moa_email', with: 'test_moa@gmail.com')
      fill_in('moa_phone', with: '0600000000')
      find('#MoaBtn').click
      expect(page).to have_css('.is-invalid')
    end

    scenario "Rerender MOE form when not filling right" do
      visit(moes_path)
      find('.btn-blue').click
      fill_in('moe_name', with: 'Test moe')
      fill_in('moe_representative', with: 'Test moe')
      fill_in('moe_email', with: 'test_moe@gmail.com')
      fill_in('moe_phone', with: '0600000000')
      find('#MoeBtn').click
      expect(page).to have_css('.is-invalid')
    end

    scenario "Rerender AntiPoison when not filling right" do
      visit(anti_poisons_path)
      find('.btn-blue').click
      fill_in('anti_poison_address', with: 'Test anti_poison')
      fill_in('anti_poison_phone', with: '0600000000')
      find('#AntiPoisonBtn').click
      expect(page).to have_css('.is-invalid')
    end

    scenario "Rerender Demining when not filling right" do
      visit(deminings_path)
      find('.btn-blue').click
      fill_in('demining_address', with: 'Test demining')
      fill_in('demining_phone', with: '0600000000')
      find('#DeminingBtn').click
      expect(page).to have_css('.is-invalid')
    end

    scenario "Rerender Sos Hand when not filling right" do
      visit(sos_hands_path)
      find('.btn-blue').click
      fill_in('sos_hand_address', with: 'Test sos_hand')
      fill_in('sos_hand_phone', with: '0600000000')
      find('#SosBtn').click
      expect(page).to have_css('.is-invalid')
    end

    scenario "Rerender Hospital when not filling right" do
      visit(hospitals_path)
      find('.btn-blue').click
      fill_in('hospital_address', with: 'Test hospital')
      fill_in('hospital_phone', with: '0600000000')
      find('#HospitalBtn').click
      expect(page).to have_css('.is-invalid')
    end

    scenario "Rerender Direcct when not filling right" do
      visit(direccts_path)
      find('.btn-blue').click
      fill_in('direcct_fax', with: '0600000000')
      fill_in('direcct_phone', with: '0600000000')
      find('#DirecctBtn').click
      expect(page).to have_css('.is-invalid')
    end

    scenario "Rerender Regional Committee when not filling right" do
      visit(regional_committees_path)
      find('.btn-blue').click
      fill_in('regional_committee_name', with: 'Test regional_committee')
      fill_in('regional_committee_phone', with: '0600000000')
      fill_in('regional_committee_fax', with: '0600000000')
      find('#RegionalBtn').click
      expect(page).to have_css('.is-invalid')
    end

    scenario "Rerender Pension Insurance when not filling right" do
      visit(pension_insurances_path)
      find('.btn-blue').click
      fill_in('pension_insurance_address', with: 'Test pension_insurance')
      fill_in('pension_insurance_fax', with: '0600000000')
      find('#PensionBtn').click
      expect(page).to have_css('.is-invalid')
    end

    scenario "Rerender Work Medecine when not filling right" do
      visit(work_medecines_path)
      find('.btn-blue').click
      fill_in('work_medecine_address', with: 'Test work_medecine')
      fill_in('work_medecine_fax', with: '0600000000')
      find('#WorkMedecineBtn').click
      expect(page).to have_css('.is-invalid')
    end

    scenario "Rerender Security Coordinator when not filling right" do
      visit(security_coordinators_path)
      find('.btn-blue').click
      fill_in('security_coordinator_name', with: 'Test security_coordinator')
      fill_in('security_coordinator_representative', with: 'Test rep security_coordinator')
      fill_in('security_coordinator_phone', with: '0600000000')
      fill_in('security_coordinator_email', with: 'test_representative@gmail.com')
      find('#SecurityBtn').click
      expect(page).to have_css('.is-invalid')
    end

    scenario "Rerender Subcontractor when not filling right" do
      visit(subcontractors_path)
      find('.btn-blue').click
      fill_in('subcontractor_name', with: 'Test subcontractor')
      fill_in('subcontractor_work', with: 'Test work')
      find('#SubcontractorBtn').click
      expect(page).to have_css('.is-invalid')
    end

    scenario "Search bar is working for anti_poison" do
      visit(anti_poisons_path)
      find('.search-db').set("Test1")
      find('.btn-orange-right').click
      expect(page).to have_current_path(anti_poisons_path)
      expect(page).to have_css('.card-bdd', count: 1)
    end

    scenario "Search bar is working for demining" do
      visit(deminings_path)
      find('.search-db').set("Test1")
      find('.btn-orange-right').click
      expect(page).to have_current_path(deminings_path)
      expect(page).to have_css('.card-bdd', count: 1)
    end

    scenario "Search bar is working for hospital" do
      visit(hospitals_path)
      find('.search-db').set("Test1")
      find('.btn-orange-right').click
      expect(page).to have_current_path(hospitals_path)
      expect(page).to have_css('.card-bdd', count: 1)
    end

    scenario "Search bar is working for moa" do
      visit(moas_path)
      find('.search-db').set("Test1")
      find('.btn-orange-right').click
      expect(page).to have_current_path(moas_path)
      expect(page).to have_css('.card-bdd', count: 1)
    end

    scenario "Search bar is working for moe" do
      visit(moes_path)
      find('.search-db').set("Test1")
      find('.btn-orange-right').click
      expect(page).to have_current_path(moes_path)
      expect(page).to have_css('.card-bdd', count: 1)
    end

    scenario "Search bar is working for pension_insurance" do
      visit(pension_insurances_path)
      find('.search-db').set("Test1")
      find('.btn-orange-right').click
      expect(page).to have_current_path(pension_insurances_path)
      expect(page).to have_css('.card-bdd', count: 1)
    end

    scenario "Search bar is working for regional_committee" do
      visit(regional_committees_path)
      find('.search-db').set("Test1")
      find('.btn-orange-right').click
      expect(page).to have_current_path(regional_committees_path)
      expect(page).to have_css('.card-bdd', count: 1)
    end

    scenario "Search bar is working for security_coordinator" do
      visit(security_coordinators_path)
      find('.search-db').set("Test1")
      find('.btn-orange-right').click
      expect(page).to have_current_path(security_coordinators_path)
      expect(page).to have_css('.card-bdd', count: 1)
    end

    scenario "Search bar is working for work_medecine" do
      visit(work_medecines_path)
      find('.search-db').set("Test1")
      find('.btn-orange-right').click
      expect(page).to have_current_path(work_medecines_path)
      expect(page).to have_css('.card-bdd', count: 1)
    end

    scenario "Search bar is working for sos_hand" do
      visit(sos_hands_path)
      find('.search-db').set("Test1")
      find('.btn-orange-right').click
      expect(page).to have_current_path(sos_hands_path)
      expect(page).to have_css('.card-bdd', count: 1)
    end

    scenario "Search bar is working for direcct" do
      visit(direccts_path)
      find('.search-db').set("Test1")
      find('.btn-orange-right').click
      expect(page).to have_current_path(direccts_path)
      expect(page).to have_css('.card-bdd', count: 1)
    end
  end
end
