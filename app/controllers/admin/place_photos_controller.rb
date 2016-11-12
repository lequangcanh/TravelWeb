class Admin::PlacePhotosController < Admin::BaseController

  def index
    @place_photos = PlacePhoto.all
  end
end
