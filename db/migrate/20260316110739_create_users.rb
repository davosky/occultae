class CreateUsers < ActiveRecord::Migration[8.1]
  def change
    create_table :users do |t|
      t.string :username
      t.string :email
      t.string :password
      t.string :first_name
      t.string :last_name
      t.string :gender
      t.date :birth_date
      t.string :birth_place
      t.string :fiscal_code
      t.string :category
      t.string :region
      t.string :province
      t.string :institute
      t.string :office

      t.timestamps
    end
  end
end
