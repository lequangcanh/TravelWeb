class CreateHotelPhotos < ActiveRecord::Migration[5.0]
  def change
    create_table :hotel_photos do |t|
      t.string :image
      t.integer :hotel_id

      t.timestamps
    end
  end
end
