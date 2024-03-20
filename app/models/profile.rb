class Profile < ApplicationRecord
    belongs_to :user
    mount_uploader :avatar, AvatarUploader
    validates :username, presence: true, length: { minimum: 6 }, format: { with: /\A[a-zA-Z]+\z/, message: "Используйте латиницу" }
    validate :username_unique
    private

    def username_unique
      if Profile.exists?(username: username) && Profile.find_by(username: username).id != self.id
        errors.add(:username, "Занят")
      end
  end
end
