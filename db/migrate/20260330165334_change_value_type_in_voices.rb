class ChangeValueTypeInVoices < ActiveRecord::Migration[8.1]
  def up
    # First convert existing string values to integers
    execute <<-SQL
      UPDATE voices SET value_type = CASE
        WHEN value_type = 'bottone' THEN '0'
        WHEN value_type = 'gruppo'  THEN '1'
        ELSE '0'
      END
    SQL

    # Then change the column type
    change_column :voices, :value_type, :integer, using: "value_type::integer", default: 0, null: false
  end

  def down
    change_column :voices, :value_type, :string
  end
end
