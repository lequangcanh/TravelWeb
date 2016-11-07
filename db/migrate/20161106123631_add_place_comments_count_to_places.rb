class AddPlaceCommentsCountToPlaces < ActiveRecord::Migration[5.0]
  def change
    add_column :places, :place_comments_count, :integer, default: 0
  end
end
