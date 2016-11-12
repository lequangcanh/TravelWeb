class Place < ApplicationRecord
  belongs_to :province
  has_many :place_photos, dependent: :destroy
  has_many :place_comments, dependent: :destroy

  validates :name, presence: true
  #validates :place_photos, length: {minimum: 1, too_short: 'are required, at least 1'}

  self.per_page = 10 #pagination

  def self.search(place_input, province_input="%")
    where("name LIKE ? AND province_id LIKE ?", "%#{place_input}%", province_input) 
  end
end
