class GroupsNodes < ActiveRecord::Migration[8.1]
  def change
    create_table :groups_nodes do |t|
      t.references :group, null: false, foreign_key: true
      t.references :node, null: false, foreign_key: true

      t.timestamps
    end
  end
end
