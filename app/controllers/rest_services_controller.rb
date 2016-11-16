class RestServicesController < ApplicationController

  def index
    province_id = params[:province_id]
    type = params[:type].to_i
    name = params[:name]
    binding.pry
    @provinces = Province.all
    restaurants = Restaurant.all
    restaurants.merge!(Restaurant.name_contains(name)) if name.present?
    restaurants.merge!(Restaurant.where(province_id: province_id)) if province_id.present?
    hotels = Hotel.all
    hotels.merge!(Hotel.name_contains(name)) if name.present?
    hotels.merge!(Hotel.where(province_id: province_id)) if province_id.present?
    all = case type
          when 0
            restaurants
          when 1
            hotels
          else
            restaurants + hotels
          end
    @rest_places = all.shuffle.paginate(page: params[:page],
                                        per_page: 30)
  end
end
