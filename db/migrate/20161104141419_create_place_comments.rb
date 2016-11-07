class CreatePlaceComments < ActiveRecord::Migration[5.0]
  def change
    create_table :place_comments do |t|
      t.timestamp :date
      t.text :content
      t.integer :user_id
      t.integer :place_id

      t.timestamps
    end
  end
end
