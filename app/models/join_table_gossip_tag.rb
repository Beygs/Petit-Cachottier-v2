class JoinTableGossipTag < ApplicationRecord
  belongs_to :tag
  belongs_to :gossip

  validates_uniqueness_of :tag, scope: :gossip
end
