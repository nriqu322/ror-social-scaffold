require 'rails_helper'

RSpec.describe Friendship, type: :model do
  before(:each) do
    @user1 = User.create(name: 'seth', email: 'coolio@q.com', password: '12345678', password_confirmation: '12345678')
    @user2 = User.create(name: 'seth', email: 'coolio2@q.com', password: '12345678', password_confirmation: '12345678')
    @friendship = Friendship.create(user_id: @user1.id, friend_id: @user2.id, confirmed: true)
  end
  context 'test friendship model' do
    it 'create valid friendship' do
      expect(@friendship.valid?).to be(true)
    end

    it 'creates an invalid friendship' do
      @friendship = Friendship.create(user_id: 55, friend_id: 175, confirmed: true)
      expect(@friendship.valid?).to eq(false)
    end
  end
end
