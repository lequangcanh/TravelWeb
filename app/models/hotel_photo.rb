class HotelPhoto < ApplicationRecord
  belongs_to :hotel
  mount_uploader :image, PhotoUploader

  def filename
    File.basename(image.path)
  end
end
