class Profile < ApplicationRecord
    belongs_to :user
    mount_uploader :avatar, AvatarUploader
    # validates :login, presence: true, length: { minimum: 6 }, format: { with: /\A[a-zA-Z0-9!@#$%^&*]+\z/, message: "Используйте латиницу" }
    validate :login_unique
    private
    def login_unique
        if Profile.exists?(login: login) && Profile.find_by(login: login).id != self.id
          errors.add(:login, "Ник занят")
        end
    end
  end
