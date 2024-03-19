class Post < ApplicationRecord
    has_many :comments
    has_many :attachments
    mount_uploader :post_image, PostImageUploader
    has_rich_text :text
    acts_as_taggable_on :tags

    has_and_belongs_to_many :users

    belongs_to :user
    def api_as_json
        {
          title: title,
          description: description,
        }
    end

    def total_comments_count
      comments.count + comments.map { |comment| comment.replies.count }.sum
    end
end
