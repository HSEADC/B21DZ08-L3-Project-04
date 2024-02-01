class Post < ApplicationRecord
    has_many :comments
    has_many :attachments
    mount_uploader :post_image, PostImageUploader

    belongs_to :user
    def api_as_json
        {
          title: title,
          description: description,
        }
    end
end
