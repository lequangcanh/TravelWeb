class CreateRestaurants < ActiveRecord::Migration[5.0]
  def change
    create_table :restaurants do |t|
      t.string :name
      t.string :address
      t.string :phone
      t.string :website
      t.string :email
      t.string :avatar
      t.text :details
      t.integer :province_id

      t.timestamps
    end
  end
end
