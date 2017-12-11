class FriendRequest < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: "User"

  validate :not_self
  validate :not_friends
  validate :not_pending
  validates :user, presence: true
  validates :friend, presence: true, uniqueness: { scope: :user }

  # adds each user to the other's friends (inverse relationship)
  # and destroys the pending request
  def accept
    user.friends << friend
    destroy
  end

private

  def not_self
    errors.add(:friend, "can't be equal to the user") if user == friend
  end

  def not_friends
    errors.add(:friend, "is already friend") if user.friends.include?(friend)
  end

  def not_pending
    errors.add(:friend, "already requested friendship") if
    user.pending_friends.include?(friend)
  end

end
