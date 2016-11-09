class PlacePhoto < ApplicationRecord
  belongs_to :place
  mount_uploader :image, PhotoUploader
end
