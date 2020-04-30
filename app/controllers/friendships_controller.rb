class FriendshipsController < ApplicationController
    def  create
        request_friend = Friendship.new(user_id: current_user.id, friend_id: params[:id])
        request_friend.save
        redirect_to root_path
    end
end
