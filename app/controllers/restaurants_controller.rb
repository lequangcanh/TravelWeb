class RestaurantsController < ApplicationController
  def index
    @provinces = Province.all
    if params[:province_id].nil?
      @restaurants = Restaurant.paginate(page: params[:page])
    else
      if params[:province_id].empty?
        @restaurants = Restaurant.search(params[:search]).paginate(page: params[:page])
      else
        @restaurants = Restaurant.search(params[:search], params[:province_id]).paginate(page: params[:page])
      end
    end
  end
end
