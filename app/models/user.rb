class User < ApplicationRecord

  before_create :build_default_profile

  acts_as_voter

  has_many :friend_requests, dependent: :destroy
  has_many :pending_friends, through: :friend_requests,
                             source: :friend

  has_many :friendships, dependent: :destroy
  has_many :friends, through: :friendships

  has_many :notifications, dependent: :destroy

  has_many :posts, foreign_key: "author_id", dependent: :destroy

  has_one :profile

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable

  validates :name, presence: true, length: { maximum: 256 }
  validates :email, length: { maximum: 256 },
                    format: { with: VALID_EMAIL_REGEX }

  def remove_friend(friend)
    self.friends.destroy(friend)
  end

  def time_line
    Post.where("author_id IN (?) OR author_id = ? ", self.friends.to_a, id).
         order('created_at DESC')
  end

  def new_notifications?
    notifications.where(read: false).any?
  end

  def get_new_notifications
    notifications.where(read: false).order(created_at: :desc)
  end

private

  def build_default_profile
    build_profile( address: "123 FakeStreet",
                   phone: "(XXX)-555-5555",
                   about_me: "Tell about yourself!");
    true
  end

end
