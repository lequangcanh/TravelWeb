class Place < ApplicationRecord
  belongs_to :province
  has_many :place_photos, dependent: :destroy
  has_many :place_comments, dependent: :destroy

  validates :name, presence: true
  # validates :place_photos, length: {minimum: 1, too_short: 'are required, at least 1'}

  self.per_page = 10 # pagination

  def self.search(place_input, province_input='%')
    where('name LIKE ? AND province_id LIKE ?', "%#{place_input}%", province_input)
  end

  def rest_places
    nearby_restaurants = Restaurant.where(province_id: province_id)
                                   .order('RANDOM()')
                                   .limit(Faker::Number.between(2, 5))
    nearby_hotels = Hotel.where(province_id: province_id)
                         .order('RANDOM()')
                         .limit(Faker::Number.between(2, 5))
    nearby_restaurants + nearby_hotels
  end

  def nearby
    Place.where(province_id: province_id)
         .where.not(id: id)
         .order('RANDOM()').limit(5)
  end

  def banner_photos
    place_photos.select { |photo| photo.image.landscape? }
  end

  def represent_photo
    banners = banner_photos
    if banners.empty?
      place_photos.first
    else
      banners.first
    end
  end
end
