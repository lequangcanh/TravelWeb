class Admin::PlacePhotosController < ApplicationController
  layout 'admin/layouts/admin_panel'

  def index
    @place_photos = PlacePhoto.all
  end
end
