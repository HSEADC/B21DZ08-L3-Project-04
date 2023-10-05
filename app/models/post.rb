class Post < ApplicationRecord
    has_many :comments
    mount_uploader :post_image, PostImageUploader
end
