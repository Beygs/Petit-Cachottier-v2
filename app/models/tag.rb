class Tag < ApplicationRecord
  validates :title,
    presence: true,
    uniqueness: true

  has_many :join_table_gossip_tags
  has_many :gossips, through: :join_table_gossip_tags
end
