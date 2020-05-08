require 'rails_helper'

RSpec.describe 'Chekcing posts: ', type: :feature do
  scenario 'valid inputs and user creation' do
    visit new_user_registration_path
    fill_in 'Name', with: 'Joshua'
    fill_in 'Email', with: 'joshua@email.com'
    fill_in 'Password', with: '123456'
    fill_in 'Password_Confirmation', with: '123456'
    click_on 'submit_form'
    visit root_path
    fill_in :post_content, with: 'Joshua is here'
    click_on 'submit-post-form'
    visit root_path
    expect(page).to have_content('Joshua is here')
  end

  scenario 'user only gets to see posts from itself and friends' do
    @user = User.create(name: 'seth', email: 'cool@q.com', password: '12345678', password_confirmation: '12345678')
    @user2 = User.create(name: 'john', email: 'coolio2@q.com', password: '12345678', password_confirmation: '12345678')
    @user3 = User.create(name: 'carl', email: 'coolllll@q.com', password: '12345678', password_confirmation: '12345678')
    Post.create(user_id: @user.id, content: 'blaaaaa')
    Post.create(user_id: @user2.id, content: 'more blaaaaa')
    Post.create(user_id: @user3.id, content: 'even more blaaaaa')
    Friendship.create(user_id: @user.id, friend_id: @user2.id, confirmed: true)

    visit new_user_session_path
    fill_in 'email', with: 'cool@q.com'
    fill_in 'password', with: '12345678'
    click_on 'Log in'
    visit root_path
    expect(page).to have_content('blaaaaa')
    expect(page).to have_content('more blaaaaa')
    expect(page).not_to have_content('even more blaaaaa')
  end
end
