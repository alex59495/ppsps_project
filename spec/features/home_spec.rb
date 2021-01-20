require 'rails_helper'

RSpec.feature "Home View", type: :feature, js: true do
  scenario 'Display the contact modal' do
    visit(root_path)
    find('#btn-display-modal').click
    expect(page).to have_css('.show')
    expect(page).not_to have_css('.swal2-backdrop-show')
  end

  scenario 'Send an email' do
    visit(root_path)
    find('#btn-display-modal').click
    fill_in('name', with: 'Lenoir MAXENCE')
    fill_in('email', with: 'test@gmail.com')
    fill_in('description', with: 'My reasons')
    find('#btn-send-mail').click
    expect(page).to have_css('.swal2-backdrop-show')
  end
end
