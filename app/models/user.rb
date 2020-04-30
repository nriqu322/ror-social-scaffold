class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { maximum: 20 }

  has_many :posts
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  has_many :friendships
  has_many :inverse_friendships, :class_name => "Friendship", :foreign_key => "friend_id"


  # Find Friends
  def friends
    # find friends in friend column (as requester)
    friends_array = friendships.map{|friendship| friendship.friend if friendship.confirmed}
    # find friends in user column (as requested)
    friends_array + inverse_friendships.map{|friendship| friendship.user if friendship.confirmed}
    # clean array from nil values
    friends_array.compact
  end


  # Users who have yet to confirm friend requests (the one that sends the invite)
  def pending_friends
    friendships.map{|friendship| friendship.friend if !friendship.confirmed}.compact
  end

  # Users who have requested to be friends (the one that receives the invite checks who send the invite)
  def friend_requests
    inverse_friendships.map{|friendship| friendship.user if !friendship.confirmed}.compact
  end

  # Set confirmation to true
  def confirm_friend(user)
    friendship = inverse_friendships.find{|friendship| friendship.user == user}
    friendship.confirmed = true
    friendship.save
  end

  # Fiend a specific friend
  def friend?(user)
    friends.include?(user)
  end
end
