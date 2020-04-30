class FriendshipsController < ApplicationController
    def  create
        request_friend = Friendship.new(user_id: current_user.id, friend_id: params[:id])
        request_friend.save
        redirect_to root_path
    end

    def edit
        fs = Friendship.where(user_id: params[:id], friend_id: current_user.id)
        if params[:choice] == '0'
            Friendship.destroy(fs.ids)
        elsif params[:choice] == '1'
            friendship = Friendship.find_by_id(fs.ids)
            friendship.confirmed = true
            friendship.save
        end
        redirect_to users_path
    end
end
