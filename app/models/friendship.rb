class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: 'User'

  validate :friendship_valid?

  def friendship_valid?
    if (Friendship.where(user_id: user_id, friend_id: friend_id, confirmed: true).exists? ||
    Friendship.where(user_id: friend_id, friend_id: user_id, confirmed: true).exists? ||
    user_id == friend_id) 
    errors.add(:user_id, "cannot have duplicate id's")
    end
  end 
end
