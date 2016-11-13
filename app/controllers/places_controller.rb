class PlacesController < ApplicationController
  include Places

  def index
  end

  def show
    begin
      @place = Place.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      render status: :not_found
      return
    end
    @represent_image = @place.place_photos.first
    @nearby_places = Place.where(province_id: @place.province_id)
                          .where.not(id: @place.id)
                          .order('RANDOM()').limit(5)
    nearby_restaurants = Restaurant.where(province_id: @place.province_id)
                                   .order('RANDOM()')
                                   .limit(Faker::Number.between(2, 5))
    nearby_hotels = Hotel.where(province_id: @place.province_id)
                         .order('RANDOM()')
                         .limit(Faker::Number.between(2, 5))
    @rest_places = nearby_restaurants + nearby_hotels
    @comment = PlaceComment.new if current_user.present?
    @comments = @place.place_comments.order(created_at: :desc)
    @place.view_count += 1
    @place.save!
  end
end
