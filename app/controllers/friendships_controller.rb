class FriendshipsController < ApplicationController
    def  create
        request_friend = Friendship.new(user_id: current_user.id, friend_id: params[:id])
        request_friend.save
        redirect_to root_path
    end

    def edit
        fs = Friendship.where(user_id: params[:id], friend_id: current_user.id)
        Friendship.destroy(fs.ids)
        redirect_to users_path
    end
end
