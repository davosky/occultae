class CreateNodes < ActiveRecord::Migration[8.1]
  def change
    create_table :nodes do |t|
      t.string :name
      t.string :ancestry
      t.integer :ancestry_depth

      t.timestamps
    end
  end
end
