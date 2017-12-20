class Post < ApplicationRecord
  acts_as_votable
  belongs_to :author, class_name: 'User'
  has_many :comments

  validates :author_id, :content, presence: :true
  validates :content, length: { maximum: 1000 }
end