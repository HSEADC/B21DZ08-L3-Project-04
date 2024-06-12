class UsersController < ApplicationController
    before_action :authenticate_user!
    
    def follow
        @follower = User.find(params[:current_user_id])
        @followed = User.find(params[:user_id])
        
        following = Following.new(follower_id: @follower.id, followed_id: @followed.id)
         if following.save
            puts "Пользователь #{@follower.id} подписан на #{@followed.id}"
        else
            puts "бляяя"
        end
    end
  
    def unfollow
        @follower = User.find(params[:current_user_id])
        @followed = User.find(params[:user_id])

        following = Following.find_by(follower_id: @follower.id, followed_id: @followed.id)
        following.destroy if following
    end
  end
  