class ChangeValueInVoices < ActiveRecord::Migration[8.1]
  def up
    rename_column :voices, :value, :value_old
    add_column :voices, :value, :integer, default: 0, null: false

    execute <<-SQL
      UPDATE voices SET value = CASE
        WHEN value_old = 'SI' THEN 0
        WHEN value_old = 'NO' THEN 1
        ELSE 0
      END
    SQL

    remove_column :voices, :value_old
  end

  def down
    rename_column :voices, :value, :value_old
    add_column :voices, :value, :string
    execute <<-SQL
      UPDATE voices SET value = CASE
        WHEN value_old = 0 THEN 'SI'
        WHEN value_old = 1 THEN 'NO'
        ELSE 'SI'
      END
    SQL
    remove_column :voices, :value_old
  end
end
