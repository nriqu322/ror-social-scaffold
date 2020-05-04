require 'rails_helper'

RSpec.describe 'Like a post', type: :feature do
    scenario 'do a valid like in a post' do
      visit new_user_registration_path
      fill_in 'Name', with: "Joshua"
      fill_in 'Email', with: "joshua@email.com"
      fill_in 'Password', with: "123456"
      fill_in 'Password_Confirmation', with: "123456"
      click_on "submit_form"
      visit root_path
      fill_in :post_content, with: "Joshua is here"
      click_on "submit-post-form"
      visit root_path
      click_on "Like!"
      expect(page).to have_content("Dislike!")
    end
end