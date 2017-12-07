class FriendRequest < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: "User"

  validate :not_self
  validate :not_friends
  validate :not_pending
  validates :user, presence: true
  validates :friend, presence: true, uniqueness: { scope: :user }

private

  def not_self
    errors.add(:friend, "can't be equal to the user") if user == friend
  end

  def not_friends
    erros.add(:friend, "is already friend") if user.friends.include?(friend)
  end

  def not_pending
    errors.add(:friend, "already requested friendship") if
    friend.pending_friends.include?(friend)
  end

end
