class PlacesController < ApplicationController
  include Places

  def index

  end

  def new
    @place = Place.new
    @provinces = Province.all
  end

  def show
    @place = Place.find(params[:id])
  end

  def create
    result = create_place(params)
    if result[:errors].empty?
      flash[:success] = "#{params[:place][:name]} created successfully."
      redirect_to result[:place]
    else
      flash[:danger] = result[:errors]
      redirect_back(fallback_location: root_path)
    end
  end
end
