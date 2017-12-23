class Post < ApplicationRecord

  acts_as_votable
  mount_uploader :picture, PictureUploader
  belongs_to :author, class_name: 'User'
  has_many :comments, dependent: :destroy

  validates :author_id, :content, presence: :true
  validates :content, length: { maximum: 1000 }
  validate :picture_size

private

  def picture_size
    if picture.size > 5.megabytes
      errors.add(:picture, "should be less than 5MB.")
    end
  end

end
