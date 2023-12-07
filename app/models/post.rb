class Post < ApplicationRecord
    has_many :comments
    has_many :attachments
    mount_uploader :post_image, PostImageUploader

    belongs_to :user
end
