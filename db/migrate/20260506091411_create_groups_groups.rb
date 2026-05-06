class CreateGroupsGroups < ActiveRecord::Migration[8.1]
  def change
    create_table :groups_groups do |t|
      t.bigint :parent_group_id, null: false
      t.bigint :child_group_id, null: false
    end

    add_index :groups_groups, :parent_group_id
    add_index :groups_groups, :child_group_id
    add_index :groups_groups, [ :parent_group_id, :child_group_id ], unique: true
  end
end
