class Hotel < ApplicationRecord
  belongs_to :province
  has_many :hotel_photos
end
