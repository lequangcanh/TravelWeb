class PlacesController < ApplicationController
  include Places

  def index
    @provinces = Province.all
    if params[:province_id].nil?
      @places = Place.paginate(page: params[:page])
    else
      if params[:province_id].empty?
        @places = Place.search(params[:search]).paginate(page: params[:page])
      else
        @places = Place.search(params[:search], params[:province_id]).paginate(page: params[:page])
      end
    end
  end

  def show
    begin
      @place = Place.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      render status: :not_found
      return
    end
    @represent_photo = @place.place_photos.first
    @nearby_places = @place.nearby
    @rest_places = @place.rest_places
    @comment = PlaceComment.new if current_user.present?
    @comments = @place.place_comments.order(created_at: :desc)
    @place.view_count += 1
    @place.save!
  end
end
