require 'rails_helper'

RSpec.feature "React Handling", type: :feature, js: true do
  feature 'Logged as User Admin' do
    before :all do
      @user = create(:user_admin)
      moa = create(:moa, company: @user.company)
      moe = create(:moe, company: @user.company)
      direcct = create(:direcct, company: @user.company)
      pension_insurance = create(:pension_insurance, company: @user.company)
      work_medecine = create(:work_medecine, company: @user.company)
      hospital = create(:hospital, company: @user.company)
      demining = create(:demining, company: @user.company)
      anti_poison = create(:anti_poison, company: @user.company)
      regional_committee = create(:regional_committee, company: @user.company)
      sos_hand = create(:sos_hand, company: @user.company)
      security_coordinator = create(:security_coordinator, company: @user.company)
      @subcontractors = create_list(:subcontractor, 5, company: @user.company)
      @risks = create_list(:risk, 5)
      @site_installations = create_list(:site_installation, 5)
      @altitude_works = create_list(:altitude_work, 5)
      @ppsp = create(:ppsp, user: @user, moa: moa, moe: moe, direcct: direcct, work_medecine: work_medecine, hospital: hospital,
                            pension_insurance: pension_insurance, demining: demining, anti_poison: anti_poison, regional_committee: regional_committee,
                            sos_hand: sos_hand, security_coordinator: security_coordinator)
    end

    feature 'React within the form selected database' do
      before do
        login_as(@user)
      end

      scenario "Can see the list of Subcontractor's options" do
        visit(new_ppsp_path)
        count = @subcontractors.size
        find('.form-group.check_boxes.optional.ppsp_subcontractors').all('input').size
        expect(count).to eq(@subcontractors.size)
      end

      scenario "Can see the list of Risk's options" do
        visit(new_ppsp_path)
        count = @risks.size
        find('.form-group.check_boxes.optional.ppsp_risks').all('input').size
        expect(count).to eq(@risks.size)
      end

      scenario "Can see the list of Site Installation's options" do
        visit(new_ppsp_path)
        count = @site_installations.size
        find('.form-group.check_boxes.optional.ppsp_site_installations').all('input').size
        expect(count).to eq(@site_installations.size)
      end

      scenario "Can see the list of Altitude Work's options" do
        visit(new_ppsp_path)
        count = @altitude_works.size
        find('.form-group.check_boxes.optional.ppsp_altitude_works').all('input').size
        expect(count).to eq(@altitude_works.size)
      end

      scenario 'When click on subcontractor option, actualize form list options + add in the addList' do
        visit(new_ppsp_path)
        count_form_list = find('.form-group.check_boxes.optional.ppsp_subcontractors').all('input').size
        count_add_list = find('.form-selected-subcontractor').all('input').size
        find("#ppsp_subcontractors_#{@subcontractors.first.id}").click
        expect(find('.form-group.check_boxes.optional.ppsp_subcontractors').all('input').size).to eq(count_form_list - 1)
        expect(find('.form-selected-subcontractor').all('input').size).to eq(count_add_list + 1)
      end

      scenario 'When click on risk option, actualize form list options + add in the addList' do
        visit(new_ppsp_path)
        count_form_list = find('.form-group.check_boxes.optional.ppsp_risks').all('input').size
        count_add_list = find('.form-selected-risk').all('input').size
        find("#ppsp_risks_#{@risks.first.id}").click
        expect(find('.form-group.check_boxes.optional.ppsp_risks').all('input').size).to eq(count_form_list - 1)
        expect(find('.form-selected-risk').all('input').size).to eq(count_add_list + 1)
      end

      scenario 'When click on site installation option, actualize form list options + add in the addList' do
        visit(new_ppsp_path)
        count_form_list = find('.form-group.check_boxes.optional.ppsp_site_installations').all('input').size
        count_add_list = find('.form-selected-site_installation').all('input').size
        find("#ppsp_site_installations_#{@site_installations.first.id}").click
        expect(find('.form-group.check_boxes.optional.ppsp_site_installations').all('input').size).to eq(count_form_list - 1)
        expect(find('.form-selected-site_installation').all('input').size).to eq(count_add_list + 1)
      end

      scenario 'When click on altitude work option, actualize form list options + add in the addList' do
        visit(new_ppsp_path)
        count_form_list = find('.form-group.check_boxes.optional.ppsp_altitude_works').all('input').size
        count_add_list = find('.form-selected-altitude_work').all('input').size
        find("#ppsp_altitude_works_#{@altitude_works.first.id}").click
        expect(find('.form-group.check_boxes.optional.ppsp_altitude_works').all('input').size).to eq(count_form_list - 1)
        expect(find('.form-selected-altitude_work').all('input').size).to eq(count_add_list + 1)
      end

      feature 'When delete a selected subcontractor, actualize form list options' do
        before do
          @subcontractor_add = create_list(:subcontractor, 2, company: @user.company)
          @ppsp.subcontractors = @subcontractor_add
          @risk_add = create_list(:risk, 2)
          @ppsp.risks = @risk_add
          @altitude_work_add = create_list(:altitude_work, 2)
          @ppsp.altitude_works = @altitude_work_add
          @site_installation_add = create_list(:site_installation, 2)
          @ppsp.site_installations = @site_installation_add
        end

        scenario 'Actualize list subcontractors option when delete' do
          visit(edit_ppsp_path(@ppsp))
          count = find('#containerSelectedSubcontractors').all('.card-form-selected').size
          first('#containerSelectedSubcontractors > .card-form-selected > .card-form-delete').click
          sleep 2
          expect(find('#containerSelectedSubcontractors').all('.card-form-selected').size).to eq(count - 1)
        end

        scenario 'Actualize site installation list option when delete' do
          visit(edit_ppsp_path(@ppsp))
          count = find('#containerSelectedSiteInstallations').all('.card-form-selected').size
          first('#containerSelectedSiteInstallations > .card-form-selected > .card-form-delete').click
          sleep 2
          expect(find('#containerSelectedSiteInstallations').all('.card-form-selected').size).to eq(count - 1)
        end

        scenario 'Actualize risks list option when delete' do
          visit(edit_ppsp_path(@ppsp))
          count = find('#containerSelectedRisks').all('.card-form-selected').size
          first('#containerSelectedRisks > .card-form-selected > .card-form-delete').click
          sleep 2
          expect(find('#containerSelectedRisks').all('.card-form-selected').size).to eq(count - 1)
        end

        scenario 'Actualize altitude works list option when delete' do
          visit(edit_ppsp_path(@ppsp))
          count = find('#containerSelectedAltitudeWorks').all('.card-form-selected').size
          first('#containerSelectedAltitudeWorks > .card-form-selected > .card-form-delete').click
          sleep 2
          expect(find('#containerSelectedAltitudeWorks').all('.card-form-selected').size).to eq(count - 1)
        end
      end
    end
  end
end
