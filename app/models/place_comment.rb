class PlaceComment < ApplicationRecord
  belongs_to :place, counter_cache: true
  belongs_to :user
end
