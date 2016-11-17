class AddViewCountToPlaces < ActiveRecord::Migration[5.0]
  def change
    add_column :places, :view_count, :integer, default: 0
  end
end
