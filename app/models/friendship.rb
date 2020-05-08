class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: 'User'

  validate :friendship_valid?

  after_update :create_inverse_friendship

  private

  def friendship_valid?
    if Friendship.where(user_id: user_id, friend_id: friend_id, confirmed: true).exists? ||
       Friendship.where(user_id: friend_id, friend_id: user_id, confirmed: true).exists? ||
       user_id == friend_id
      errors.add(:user_id, "cannot have duplicate id's")
    end
  end

  def create_inverse_friendship
    reverse_fs = Friendship.new(user_id: user_id, friend_id: friend_id, confirmed: true)
    reverse_fs.save
  end
end
