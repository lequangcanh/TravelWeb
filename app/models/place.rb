class Place < ApplicationRecord
  belongs_to :province
<<<<<<< HEAD
  has_many :place_photos
  has_many :place_comments

  self.per_page = 10 #pagination

  def self.search(search)
    where("name LIKE ?", "%#{search}%") 
  end

  def self.getPlacesOfProvince(id)
    where("province_id = ?", id)
  end
=======
  has_many :place_photos, dependent: :destroy
  has_many :place_comments, dependent: :destroy

  validates :name, presence: true
  validates :place_photos, length: {minimum: 1, too_short: 'are required, at least 1'}
>>>>>>> develope
end
