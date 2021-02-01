require 'rails_helper'

RSpec.feature "Ppsps Views", type: :feature, js: true do
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
      @ppsp = create(:ppsp, user: @user, moa: moa, moe: moe, direcct: direcct, work_medecine: work_medecine, hospital: hospital,
                            pension_insurance: pension_insurance, demining: demining, anti_poison: anti_poison, regional_committee: regional_committee,
                            sos_hand: sos_hand, security_coordinator: security_coordinator)
    end

    feature 'React within the form' do
      before do
        login_as(@user)
      end

      scenario "Can see the list of Subcontractor's options" do
        visit(new_ppsp_path)
        count = @subcontractors.size
        find('.form-group.check_boxes.optional.ppsp_subcontractors').all('input').size
        expect(count).to eq(@subcontractors.size)
      end

      scenario 'When click on option, actualize form list options + add in the addList' do
        visit(new_ppsp_path)
        count_form_list = find('.form-group.check_boxes.optional.ppsp_subcontractors').all('input').size
        count_add_list = find('.form-selected-subcontractor').all('input').size
        find("#ppsp_subcontractors_#{@subcontractors.first.id}").click
        expect(find('.form-group.check_boxes.optional.ppsp_subcontractors').all('input').size).to eq(count_form_list - 1)
        expect(find('.form-selected-subcontractor').all('input').size).to eq(count_add_list + 1)
      end

      feature 'When delete a selected subcontractor, actualize form list options' do
        before do
          @subcontractor_add = create_list(:subcontractor, 2, company: @user.company)
          @ppsp.subcontractors = @subcontractor_add
        end

        scenario 'Actualize list option when delete' do
          visit(edit_ppsp_path(@ppsp))
          count = find('#containerSelectedSubcontractors').all('.card-form-selected').size
          first('#containerSelectedSubcontractors > .card-form-selected > .card-form-delete').click
          sleep 2
          expect(find('#containerSelectedSubcontractors').all('.card-form-selected').size).to eq(count - 1)
        end
      end
    end
  end
end
