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

  def new
    @place = Place.new
    @provinces = Province.all
    @photos = @place.place_photos
  end

  def edit
    @place = Place.find(params[:id])
    @provinces = Province.all
    @photos = @place.place_photos.all
    gon.photosUrl = @photos.map { |photo| photo.image.url }
    gon.previewConfigs = @photos.map { |photo|
      {
        caption: photo.filename,
        size: photo.image.size,
        frameAttr: {'data-id' => photo.id}
      }
    }
    render :new
  end

  def update
    result = update_place(params)
    if result[:errors].empty?
      flash.now[:success] = "#{result[:place].name} updated successfully."
      redirect_to result[:place]
    else
      flash.now[:danger] = result[:errors]
      redirect_back(fallback_location: root_path)
    end
  end

  def show
    @place = Place.find(params[:id])
    @comment = PlaceComment.new if current_user.present?
    @comments = @place.place_comments.order(created_at: :desc)
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
