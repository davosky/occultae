class Node < ApplicationRecord
  has_ancestry cache_depth: true

  has_many :features, -> { order(:grouping, :name) }, dependent: :destroy

  has_and_belongs_to_many :groups, -> { order(:name) }
  has_and_belongs_to_many :users, -> { order(:last_name) }

  validates :name, presence: true
  validates :name, uniqueness: true

  def self.ransackable_attributes(auth_object = nil)
    [ "name" ]
  end

  def self.ransackable_associations(auth_object = nil)
    []
  end
end
