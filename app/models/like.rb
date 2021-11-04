class Like < ApplicationRecord
  belongs_to :user
  belongs_to :likeable, polymorphic: true

  validates_uniqueness_of :user, scope: :likeable
end
