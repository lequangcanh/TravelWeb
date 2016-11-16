class Admin::HotelsController < Admin::BaseController

  def index
    @hotels = params[:search].present? ? Hotel.search(params[:search]).paginate(page: params[:page]) : Hotel.paginate(page: params[:page])
  end

  def new
    @hotel = Hotel.new
    @provinces = Province.all
  end

  def create
    result = create_hotel(params)
    if result[:errors].empty?
      flash.now[:success] = "#{params[:hotel][:name]} created successfully."
      redirect_to hotel_path(result[:hotel])
    else
      flash.now[:danger] = result[:errors]
      redirect_back(fallback_location: admin_hotels_path)
    end
  end

  def edit
    @hotel = Hotel.find(params[:id])
    @provinces = Province.all
    @photos = @hotel.hotel_photos.all
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
    result = update_hotel(params)
    if result[:errors].empty?
      flash.now[:success] = "#{result[:hotel].name} updated successfully."
      redirect_to hotel_path(result[:hotel])
    else
      flash.now[:danger] = result[:errors]
      redirect_back(fallback_location: admin_hotels_path)
    end
  end

  def destroy
    Hotel.find(params[:id]).destroy
    redirect_to admin_hotels_path
  end

  def destroy
    Hotel.find(params[:id]).destroy
    redirect_to admin_hotels_path
  end

  private
  def hotel_params(params)
    params.require(:hotel).permit(:name, :province_id, :address, :phone,
        :email, :website, :details)
  end

  def create_hotel(params)
    hotel = Hotel.new(hotel_params(params))
    Hotel.transaction do
      photos = params[:photos].present? ? params[:photos][:files] : []
      photos.each do |file|
        hotel.hotel_photos.new(image: file)
      end
      hotel.save!
    end
    return {hotel: hotel, errors: []}
  rescue ActiveRecord::RecordInvalid => e
    {hotel: nil, errors: e.record.errors.full_messages}
  end

  def update_hotel(params)
    hotel = Hotel.find(params[:id])
    Hotel.transaction do
      # remove all old image
      hotel.hotel_photos.delete_all
      # make new image
      photos = params[:photos].present? ? params[:photos][:files] : []
      photos.each do |file|
        hotel.hotel_photos.new(image: file)
      end
      hotel.update!(hotel_params(params))
    end
    return {hotel: hotel, errors: []}
  rescue ActiveRecord::RecordInvalid => e
    {hotel: nil, errors: e.record.errors.full_messages}
  end
end
