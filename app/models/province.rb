class Province < ApplicationRecord
  has_many :places, dependent: :restrict_with_error
  has_many :hotels, dependent: :restrict_with_error
  has_many :restaurants, dependent: :restrict_with_error
end
