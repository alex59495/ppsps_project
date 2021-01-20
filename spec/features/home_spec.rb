require 'rails_helper'

RSpec.feature "Home View", type: :feature, js: true do
  scenario 'Display the contact modal' do
    visit(root_path)
    find('#btn-display-modal').click
    expect(page).to have_css('.show')
  end
end
