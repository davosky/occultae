class UsersVoices < ActiveRecord::Migration[8.1]
  def change
    create_table :users_voices do |t|
      t.references :user, null: false, foreign_key: true
      t.references :voice, null: false, foreign_key: true

      t.timestamps
    end
  end
end
