class Province < ApplicationRecord
  has_many :places
  has_many :hotels
  has_many :restaurants

  self.per_page = 10 #pagination
  validates :name, presence: true, length: {maximum: 255}

  def self.search(search)
    where("name LIKE ?", "%#{search}%") 
  end
end
