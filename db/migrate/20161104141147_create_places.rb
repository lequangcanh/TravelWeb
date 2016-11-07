class CreatePlaces < ActiveRecord::Migration[5.0]
  def change
    create_table :places do |t|
      t.string :name
      t.string :avatar
      t.text :description
      t.integer :province_id

      t.timestamps
    end
  end
end
