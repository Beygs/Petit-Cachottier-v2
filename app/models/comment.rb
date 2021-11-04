class Comment < ApplicationRecord
  validates :content,
    presence: true,
    length: { minimum: 2 }

  belongs_to :user
  belongs_to :commentable, polymorphic: true
  has_many :comments, as: :commentable
  has_many :likes, as: :likeable
end
