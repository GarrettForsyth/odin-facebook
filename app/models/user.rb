class User < ApplicationRecord

  before_create :build_default_profile

  acts_as_voter
  has_attached_file :avatar, styles: { medium: "400x400>", thumb: "100x100" }
  validates_attachment_size :avatar, less_than: 10.megabytes
  validates_attachment_content_type :avatar, content_type:  ['image/jpeg', 'image/gif', 'image/png']


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
         :confirmable, :omniauthable, omniauth_providers: %i[facebook]

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

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.name = auth.info.name   # assuming the user model has a name
      # user.image = auth.info.image
      # If you are using confirmable and the provider(s) you use validate emails, 
      # uncomment the line below to skip the confirmation emails.
       user.skip_confirmation!
     end
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end

  def build_default_profile
    build_profile( address: "123 FakeStreet",
                   phone: "(XXX)-555-5555",
                   about_me: "Tell about yourself!");
    true
  end

  def after_confirmation
    UserMailer.welcome_email(self).deliver
  end

end
