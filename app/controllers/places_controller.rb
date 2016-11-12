class PlacesController < ApplicationController
  include Places

  def index
    @places = Place.all
    if params[:province_id].empty?
      @places = Place.search(params[:search])
    else
      @places = Place.search(params[:search],params[:province_id])
    end
  end

  def new
    @place = Place.new
    @provinces = Province.all
  end

  def show
    @place = Place.find(params[:id])
    @comments = @place.place_comments
    @place.view_count += 1
    @place.save!
  end

  def create
    result = create_place(params)
    if result[:errors].empty?
      flash.now[:success] = "#{params[:place][:name]} created successfully."
      redirect_to result[:place]
    else
      flash.now[:danger] = result[:errors]
      redirect_back(fallback_location: root_path)
    end
  end
end