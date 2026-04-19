class AddMoreToNode < ActiveRecord::Migration[8.1]
  def change
    add_column :nodes, :enabled, :boolean
    add_column :nodes, :enabled_login, :boolean
    add_column :nodes, :application_filters, :string
  end
end
