class Province < ApplicationRecord
  has_many :places
  has_many :hotels
  has_many :restaurants
end
