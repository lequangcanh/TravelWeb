class Place < ApplicationRecord
  belongs_to :province
  has_many :place_photos
  has_many :place_comments
end
