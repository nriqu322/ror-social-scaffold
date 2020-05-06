require 'rails_helper'

RSpec.describe User, type: :model do
  before(:each) do
    @user = User.create(name: 'seth', email: 'cool@q.com', password: '12345678', password_confirmation: '12345678')
    @user2 = User.create(name: 'john', email: 'coolio2@q.com', password: '12345678', password_confirmation: '12345678')
    @user3 = User.create(name: 'paul', email: 'coolio3@q.com', password: '12345678', password_confirmation: '12345678')
    @friendship = Friendship.create(user_id: @user.id, friend_id: @user2.id, confirmed: true)
    @friendship2 = Friendship.create(user_id: @user2.id, friend_id: @user3.id, confirmed: false)
  end
  context 'tests the user model creation' do
    it 'create valid user' do
      expect(@user.valid?).to eq(true)
    end

    it 'creates an invalid user' do
      @user = User.create(name: 'Hello my name is awesomo-3000', email: 'cool@q.com',
                          password: '12345678', password_confirmation: '12345678')
      expect(@user.valid?).to eq(false)
    end
  end

  context 'tests the user model helper functions' do
    it 'checks if user has friends' do
      expect(@user.friends.include?(@user2)).to be(true)
    end

    it 'checks if user has no friend by @user3' do
      expect(@user.friends.include?(@user3)).to be(false)
    end

    it 'checks for pending requests' do
      expect(@user2.pending_friends.include?(@user3)).to be(true)
    end

    it 'checks if a request has been received' do
      expect(@user3.friend_requests.include?(@user2)).to be(true)
    end

    it 'checks if two users are friends' do
      expect(@user.friend?(@user2)).to be(true)
    end

    it 'checks if two users are friends (bi-directional)' do
      expect(@user2.friend?(@user)).to be(true)
    end
  end
end
