class RestaurantsController < ApplicationController
  def index
    @restaurants = Restaurant.all
    @provinces = Province.all
  end
end
