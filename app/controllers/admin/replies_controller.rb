class Admin::RepliesController < ApplicationController
    before_action :authenticate_user!
    before_action :set_parent_comment, only: %i[ show new edit create update destroy ]
    before_action :set_reply, only: %i[ show new edit create update destroy ]
  
  def new
    @reply = @parent_comment.replies.build
  end

  def create
    @reply = @parent_comment.replies.new(reply_params)
    @reply.created_at = Time.now

    respond_to do |format|
      if @reply.save
        format.html { redirect_to admin_post_url(@parent_comment.post), notice: "Comment was successfully created." }
        format.json { render :show, status: :created, location: @reply }
      else
        format.html { render partial: 'admin/comments/comment', locals: { comment: @parent_comment, reply: @reply }, status: :unprocessable_entity }
        format.json { render json: @reply.errors, status: :unprocessable_entity }
      end
    end
  end
  
    private
    def set_parent_comment
        @parent_comment = Comment.find(params[:comment_id])
    end

    # def set_post
    #     @post = @comment.post.find(params[:post_id])
    # end

    def set_reply
     @reply = Comment.find(params[:comment_id])
    end
  
    def reply_params
      params.require(:comment).permit(:body, :reply_to_comment_id, :comment_id).merge(user_id: current_user.id)
    end
  end