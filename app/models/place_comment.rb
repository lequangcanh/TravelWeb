class PlaceComment < ApplicationRecord
  belongs_to :place, count_cache: true
  belongs_to :user
end
