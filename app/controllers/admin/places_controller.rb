class Admin::PlacesController < ApplicationController
  layout 'admin/layouts/admin_panel'

  def index
    @places = Place.paginate(page: params[:page])
    if params[:search]
      @places = Place.search(params[:search]).paginate(page: params[:page])
    else
      @places = Place.paginate(page: params[:page])
    end
  end

  def new
    @place = Place.new
  end

  def create
    @place = Place.create(place_params)
    if @place.save
      redirect_to admin_place_path(@place)
    else
      render 'new'
    end
  end

  def show
    @place = Place.find(params[:id])
  end

  def edit
    @place = Place.find(params[:id])
  end

  def update
    @place = Place.find(params[:id])
    if @place.update_attributes(place_params)
      redirect_to admin_place_path(@place)
    else
      render 'edit'
    end
  end

  def destroy
    Place.find(params[:id]).destroy
    redirect_to admin_places_path
  end

  private 
  def place_params
    params.require(:place).permit(:name, :avatar, :description, :province_id)
  end
end
