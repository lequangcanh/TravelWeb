class PlacePhoto < ApplicationRecord
  belongs_to :place
  mount_uploader :image, PhotoUploader

  validates :image, presence: true

  def filename
    File.basename(image.path)
  end

  def represent_image
    # select landscape image
  end
end
