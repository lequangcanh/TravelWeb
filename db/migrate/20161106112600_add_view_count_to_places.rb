class AddViewCountToPlaces < ActiveRecord::Migration[5.0]
  def change
    add_column :places, :view_count, :number, default: 0
  end
end
