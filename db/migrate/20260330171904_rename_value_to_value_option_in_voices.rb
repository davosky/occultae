class RenameValueToValueOptionInVoices < ActiveRecord::Migration[8.1]
  def change
    rename_column :voices, :value, :value_option
  end
end
