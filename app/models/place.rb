class Place < ApplicationRecord
  belongs_to :province
  has_many :place_photos, dependent: :destroy
  has_many :place_comments, dependent: :destroy

  validates :name, presence: true
  validates :place_photos, length: {minimum: 1, too_short: 'are required, at least 1'}
end
