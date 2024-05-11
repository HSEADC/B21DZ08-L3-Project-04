class User < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher


  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: self
         
  has_many :posts
  has_many :comments
  has_one :profile

  has_and_belongs_to_many :favourites, class_name: 'Post', foreign_key: 'user_id'

  has_many :favourites
  has_many :posts_i_favourited, through: :favourites, source: 'post'

  has_many :likes
  has_many :posts_i_liked, through: :likes, source: 'post'

  has_many :followings_as_follower, class_name: 'Following', foreign_key: 'follower_id'
  has_many :followings_as_followed, class_name: 'Following', foreign_key: 'followed_id'
end
