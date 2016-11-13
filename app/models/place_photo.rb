class PlacePhoto < ApplicationRecord
  belongs_to :place
  mount_uploader :image, PhotoUploader

  validates :image, presence: true

  def filename
    File.basename(image.path)
  end
end
