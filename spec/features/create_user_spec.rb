require 'rails_helper'

RSpec.describe 'Creating a user with', type: :feature do
  scenario 'valid inputs' do
    visit new_user_registration_path
    fill_in 'Name', with: 'Joshua'
    fill_in 'Email', with: 'joshua@email.com'
    fill_in 'Password', with: '123456'
    fill_in 'Password_Confirmation', with: '123456'
    click_on 'submit_form'
    visit users_path
    expect(page).to have_content('Joshua')
  end
end
