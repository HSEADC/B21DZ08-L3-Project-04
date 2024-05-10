class Post < ApplicationRecord
  include PgSearch::Model
  multisearchable against: [:title, :text]

  has_many :comments
  has_many :attachments
  mount_uploader :post_image, PostImageUploader
  has_rich_text :text

  # acts_as_taggable_on :tags

  has_many :favourites
  has_many :users_who_favourited, through: :favourites, source: 'user'

  has_many :likes
  has_many :users_who_liked, through: :likes, source: 'user'

  has_and_belongs_to_many :users

  acts_as_taggable
  acts_as_taggable_on :kinds, :themes, :languages, :nationalities

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
