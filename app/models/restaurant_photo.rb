class RestaurantPhoto < ApplicationRecord
  belongs_to :restaurant
  mount_uploader :image, PhotoUploader

  def filename
    File.basename(image.path)
  end
end
