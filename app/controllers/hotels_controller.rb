class HotelsController < ApplicationController

  def index
    @provinces = Province.all
    if params[:province_id].nil?
      @hotels = Hotel.paginate(page: params[:page])
    else
      if params[:province_id].empty?
        @hotels = Hotel.search(params[:search]).paginate(page: params[:page])
      else
        @hotels = Hotel.search(params[:search], params[:province_id]).paginate(page: params[:page])
      end
    end
  end

  def show
    place = Hotel.find(params[:id])
    province = place.province
    render json: place.as_json.merge(province: province.as_json)
  end
end
