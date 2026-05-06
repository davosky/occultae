class Group < ApplicationRecord
  has_and_belongs_to_many :users
  has_and_belongs_to_many :voices
  has_and_belongs_to_many :nodes, -> { order(:name) }
  has_and_belongs_to_many :child_groups,
    class_name: "Group",
    join_table: "groups_groups",
    foreign_key: "parent_group_id",
    association_foreign_key: "child_group_id"
  has_and_belongs_to_many :parent_groups,
    class_name: "Group",
    join_table: "groups_groups",
    foreign_key: "child_group_id",
    association_foreign_key: "parent_group_id"

  validates :name, presence: true, uniqueness: true
  validate :cannot_include_itself

  def self.ransackable_attributes(auth_object = nil)
    [ "name", "users" ]
  end

  private

  def cannot_include_itself
    errors.add(:child_groups, "non può contenere sé stesso") if child_group_ids.include?(id)
  end
end
