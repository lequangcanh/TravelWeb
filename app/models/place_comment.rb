class PlaceComment < ApplicationRecord
  belongs_to :place, counter_cache: true
  belongs_to :user
  validates :content, length: {minimum: 1, maximum: 1000}, allow_nil: true
end
