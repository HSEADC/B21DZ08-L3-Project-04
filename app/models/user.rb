class User < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher


  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: self
         
  has_many :collections, dependent: :destroy
  has_many :posts, dependent: :destroy
  has_many :comments
  has_one :profile

  has_many :saved_collections_relationships, class_name: 'SavedCollection'
  has_many :saved_collections, through: :saved_collections_relationships, source: :collection

  has_and_belongs_to_many :favourites, class_name: 'Post', foreign_key: 'user_id'

  has_many :favourites
  has_many :posts_i_favourited, through: :favourites, source: 'post'

  has_many :likes
  has_many :posts_i_liked, through: :likes, source: 'post'

  after_create :create_profile

  def create_profile
    profile = Profile.create(user_id: id, username: "Пользователь#{id}", login: "Пользователь#{id}")
    if profile.errors.any?
      puts profile.errors.full_messages
    end
  end

end
