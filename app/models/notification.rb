class Notification < ApplicationRecord
  belongs_to :user
  belongs_to :notified_by, class_name: 'User'

  validates :user_id, :notified_by_id,
      presence: true
end
