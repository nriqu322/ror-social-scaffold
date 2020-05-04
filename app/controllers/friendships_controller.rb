class FriendshipsController < ApplicationController
  def create
    request_friend = Friendship.new(user_id: current_user.id, friend_id: params[:id])
    request_friend.save
    redirect_to root_path
  end

  def update
    fs = Friendship.where(user_id: params[:id], friend_id: current_user.id)
    friendship = Friendship.find_by_id(fs.ids)
    friendship.confirmed = true
    friendship.save
    Friendship.create(user_id: current_user, friend_id: params[:id], confirmed: true)
    redirect_to users_path
  end

  def destroy
    fs = Friendship.where(user_id: params[:id], friend_id: current_user.id)
    Friendship.destroy(fs.ids)
    redirect_to users_path
  end
end
