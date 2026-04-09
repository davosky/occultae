class GroupsVoices < ActiveRecord::Migration[8.1]
  def change
    create_table :groups_voices do |t|
      t.references :group, null: false, foreign_key: true
      t.references :voice, null: false, foreign_key: true

      t.timestamps
    end
  end
end
