class FriendshipsController < ApplicationController
    def  create
        request_friend = Friendship.new(user_id: current_user.id, friend_id: params[:id])
        request_friend.save
        redirect_to root_path
    end

    def destroy
        current_user.decline_friend(params[:user_id])
        redirect_to users_path
    end
end
