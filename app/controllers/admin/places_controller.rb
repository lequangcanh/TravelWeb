class Admin::PlacesController < Admin::BaseController
  include Places

  def index
      @places = params[:search].present? ? Place.search(params[:search]).paginate(page: params[:page]) : Place.paginate(page: params[:page])
  end

  def new
    @place = Place.new
    @provinces = Province.all
  end

  def create
    result = create_place(params)
    if result[:errors].empty?
      flash.now[:success] = "#{params[:place][:name]} created successfully."
      redirect_to place_path(result[:place])
    else
      flash.now[:danger] = result[:errors]
      redirect_back(fallback_location: admin_places_path)
    end
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
  end

  def update
    result = update_place(params)
    if result[:errors].empty?
      flash.now[:success] = "#{result[:place].name} updated successfully."
      redirect_to place_path(result[:place])
    else
      flash.now[:danger] = result[:errors]
      redirect_back(fallback_location: admin_places_path)
    end
  end

  def destroy
    Place.find(params[:id]).destroy
    redirect_to admin_places_path
  end
end
