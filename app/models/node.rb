class Node < ApplicationRecord
  has_ancestry cache_depth: true

  validates :name, presence: true
  validates :name, uniqueness: true

  def self.ransackable_attributes(auth_object = nil)
    [ "name", "users", "groups" ]
  end
end
