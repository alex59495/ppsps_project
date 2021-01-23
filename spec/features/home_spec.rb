require 'rails_helper'

RSpec.feature "Home View", type: :feature, js: true do
  describe 'Contact form' do
    it 'Display the contact modal' do
      visit(root_path)
      find('#btn-display-modal').click
      expect(page).to have_css('.show')
      expect(page).not_to have_css('.swal2-backdrop-show')
    end

    it 'Send an email' do
      visit(root_path)
      find('#btn-display-modal').click
      fill_in('name', with: 'Lenoir MAXENCE')
      fill_in('email', with: 'test@gmail.com')
      fill_in('description', with: 'My reasons')
      find('#btn-send-mail').click
      expect(page).to have_css('.swal2-backdrop-show')
    end

    it 'Display an error message if a text input is not correctly filled' do
      visit(root_path)
      find('#btn-display-modal').click
      fill_in('email', with: 'test@gmail.com')
      find('#btn-send-mail').click
      message = page.find("#name").native.attribute("validationMessage")
      expect(message).to eq('Please fill out this field.')
    end

    it 'Display an error message if a email input is not correctly filled' do
      visit(root_path)
      find('#btn-display-modal').click
      fill_in('email', with: 'test@gmail')
      find('#btn-send-mail').click
      message = page.find("#email").native.attribute("validationMessage")
      expect(message).to eq('Please match the requested format.')
    end
  end
end
