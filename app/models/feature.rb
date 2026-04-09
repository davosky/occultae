class Feature < ApplicationRecord
  belongs_to :node

  has_many :voices, dependent: :destroy

  accepts_nested_attributes_for :voices, allow_destroy: true

  validates :name, :grouping, presence: true

  def self.ransackable_attributes(auth_object = nil)
    [ "name", "grouping", "node_id" ]
  end
end
