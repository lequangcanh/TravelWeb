class Province < ApplicationRecord

  self.per_page = 10 #pagination
  validates :name, presence: true, length: {maximum: 255}

  def self.search(search)
    where("name LIKE ?", "%#{search}%") 
  end

  has_many :places, dependent: :restrict_with_error
  has_many :hotels, dependent: :restrict_with_error
  has_many :restaurants, dependent: :restrict_with_error
end
