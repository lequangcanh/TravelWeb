class Admin::PlacesController < Admin::BaseController

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
        frameAttr: {'data-id': photo.id}
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

  private 
  def place_params(params)
    params.require(:place).permit(:name, :description, :province_id)
  end

  def create_place(params)
    place = Place.new(place_params(params))
    Place.transaction do
      photos = params[:photos].present? ? params[:photos][:files] : []
      photos.each do |file|
        place.place_photos.new(image: file)
      end
      place.save!
    end
    return {place: place, errors: []}
  rescue ActiveRecord::RecordInvalid => e
    {place: nil, errors: e.record.errors.full_messages}
  end

  def update_place(params)
    place = Place.find(params[:id])
    Place.transaction do
      if params[:photo_ids_for_delete].present?
        photo_ids_for_delete = JSON.parse(params[:photo_ids_for_delete])
        photo_ids_for_delete.each do |photo_id|
          PlacePhoto.find(photo_id).destroy!
        end
      end
      photos = params[:photos].present? ? params[:photos][:files] : []
      photos.each do |file|
        place.place_photos.new(image: file)
      end
      place.update!(place_params(params))
    end
    return {place: place, errors: []}
  rescue ActiveRecord::RecordInvalid => e
    {place: nil, errors: e.record.errors.full_messages}
  end
end
