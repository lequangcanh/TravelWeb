class Place < ApplicationRecord
  belongs_to :province
  has_many :place_photos, dependent: :destroy
  has_many :place_comments, dependent: :destroy
end
