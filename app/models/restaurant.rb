class Restaurant < ApplicationRecord
  belongs_to :province
  has_many :restaurant_photos

  self.per_page = 10

  def self.search(restaurant_input, province_input="%")
    where("name LIKE ? AND province_id LIKE ?", "%#{restaurant_input}%", province_input) 
  end
end
