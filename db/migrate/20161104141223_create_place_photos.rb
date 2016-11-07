class CreatePlacePhotos < ActiveRecord::Migration[5.0]
  def change
    create_table :place_photos do |t|
      t.string :image
      t.integer :place_id

      t.timestamps
    end
  end
end
