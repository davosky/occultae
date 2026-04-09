class CreateVoices < ActiveRecord::Migration[8.1]
  def change
    create_table :voices do |t|
      t.string :name
      t.string :grouping
      t.string :value
      t.string :value_type
      t.references :feature, null: false, foreign_key: true
      t.references :user, null: true, foreign_key: true
      t.references :group, null: true, foreign_key: true

      t.timestamps
    end
  end
end
