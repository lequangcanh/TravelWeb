class Place < ApplicationRecord
  belongs_to :province
  has_many :place_photos
  has_many :place_comments

  self.per_page = 10 #pagination

  def self.search(search)
    where("name LIKE ?", "%#{search}%") 
  end

  def self.getPlacesOfProvince(id)
    where("province_id = ?", id)
  end
end
