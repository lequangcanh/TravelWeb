class CreateRestaurantPhotos < ActiveRecord::Migration[5.0]
  def change
    create_table :restaurant_photos do |t|
      t.string :image
      t.integer :restaurant_id

      t.timestamps
    end
  end
end
