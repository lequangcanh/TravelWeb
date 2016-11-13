class Hotel < ApplicationRecord
  belongs_to :province
  has_many :hotel_photos

  self.per_page = 10

  def self.search(hotel_input, province_input="%")
    where("name LIKE ? AND province_id LIKE ?", "%#{hotel_input}%", province_input) 
  end
end
