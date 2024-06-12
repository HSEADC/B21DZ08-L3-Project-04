class Following < ApplicationRecord
    belongs_to :follower, class_name: 'User'
    belongs_to :followed, class_name: 'User'
    
    validates :follower_id, uniqueness: { scope: :followed_id, message: "You're already following this user" }
    validate :cannot_follow_yourself
  
    private
  
    def cannot_follow_yourself
      errors.add(:follower_id, "can't be the same as followed_id") if follower_id == followed_id
    end
end
