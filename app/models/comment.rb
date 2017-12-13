class Comment < ApplicationRecord
  acts_as_votable
  belongs_to :author, class_name: 'User'
  belongs_to :post

  validates :content, :author, :post, presence: true
  validates :content, length: { maximum: 1000 }
end
