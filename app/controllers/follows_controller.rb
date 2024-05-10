class FollowsController < ApplicationController
    def create
        @follow = Follow.new(follow_params)
        if @follow.save
          redirect_to root_path, notice: 'Followed successfully'
        else
          redirect_to root_path, alert: 'Failed to follow'
        end
      end
    
      def destroy
        @follow = Follow.find(params[:id])
        @follow.destroy
        redirect_to root_path, notice: 'Unfollowed successfully'
      end
    
      private
    
      def follow_params
        params.require(:follow).permit(:followed_id, :follower_id)
      end
end
