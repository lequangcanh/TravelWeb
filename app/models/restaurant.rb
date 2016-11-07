class Restaurant < ApplicationRecord
  belongs_to :province
  has_many :restaurant_photos
end
