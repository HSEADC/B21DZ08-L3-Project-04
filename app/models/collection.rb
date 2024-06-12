class Collection < ApplicationRecord
  belongs_to :user
  has_and_belongs_to_many :posts

  has_many :saved_collections_relationships, class_name: 'SavedCollection', dependent: :destroy
  has_many :saved_by_users, through: :saved_collections_relationships, source: :user
end
