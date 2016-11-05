class CreateHotels < ActiveRecord::Migration[5.0]
  def change
    create_table :hotels do |t|
      t.string :name
      t.string :address
      t.string :phone
      t.string :email
      t.string :website
      t.text :details
      t.string :avatar
      t.integer :province_id

      t.timestamps
    end
  end
end
