class AddReplyToCommentIdToComment < ActiveRecord::Migration[7.0]
  def change
    add_column :comments, :reply_to_comment_id, :integer
  end
end
