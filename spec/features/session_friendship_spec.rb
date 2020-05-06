RSpec.describe 'Send a friend request', type: :feature do
  before(:each) do
    @user2 = User.create(name: 'john', email: 'coolio2@q.com', password: '12345678', password_confirmation: '12345678')
    @user = User.create(name: 'seth', email: 'cool@q.com', password: '12345678', password_confirmation: '12345678')
  end
  scenario 'valid send request' do
    visit new_user_session_path
    fill_in 'email', with: 'cool@q.com'
    fill_in 'password', with: '12345678'
    click_on 'Log in'
    visit users_path
    click_on 'request-btn'
    visit users_path
    expect(page).to have_content('PENDING')
  end
  scenario 'accept friend request' do
    Friendship.create(user_id: @user2.id, friend_id: @user.id)
    visit new_user_session_path
    fill_in 'email', with: 'cool@q.com'
    fill_in 'password', with: '12345678'
    click_on 'Log in'
    visit users_path
    expect(page).to have_content('ACCEPT')
    click_on 'accept-btn'
    visit users_path
    expect(page).not_to have_content('ACCEPT')
  end
  scenario 'decline friend request' do
    Friendship.create(user_id: @user2.id, friend_id: @user.id)
    visit new_user_session_path
    fill_in 'email', with: 'cool@q.com'
    fill_in 'password', with: '12345678'
    click_on 'Log in'
    visit users_path
    expect(page).to have_content('DECLINE')
    click_on 'decline-btn'
    visit users_path
    expect(page).not_to have_content('DECLINE')
  end
end
