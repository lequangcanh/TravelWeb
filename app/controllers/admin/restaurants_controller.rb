class Admin::RestaurantsController < Admin::BaseController

  def index
      @restaurants = params[:search].present? ? Restaurant.search(params[:search]).paginate(page: params[:page]) : Restaurant.paginate(page: params[:page])
  end

  def new
    @restaurant = Restaurant.new
    @provinces = Province.all
  end

  def create
    result = create_restaurant(params)
    if result[:errors].empty?
      flash.now[:success] = "#{params[:restaurant][:name]} created successfully."
      redirect_to restaurant_path(result[:restaurant])
    else
      flash.now[:danger] = result[:errors]
      redirect_back(fallback_location: admin_restaurants_path)
    end
  end

  def edit
    @restaurant = Restaurant.find(params[:id])
    @provinces = Province.all
    @photos = @restaurant.restaurant_photos.all
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
    result = update_restaurant(params)
    if result[:errors].empty?
      flash.now[:success] = "#{result[:restaurant].name} updated successfully."
      redirect_to restaurant_path(result[:restaurant])
    else
      flash.now[:danger] = result[:errors]
      redirect_back(fallback_location: admin_restaurants_path)
    end
  end

  def destroy
    Restaurant.find(params[:id]).destroy
    redirect_to admin_restaurants_path
  end

  private
  def restaurant_params(params)
    params.require(:restaurant).permit(:name, :province_id,
        :address, :email, :phone, :website, :details)
  end

  def create_restaurant(params)
    restaurant = Restaurant.new(restaurant_params(params))
    Restaurant.transaction do
      photos = params[:photos].present? ? params[:photos][:files] : []
      photos.each do |file|
        restaurant.restaurant_photos.new(image: file)
      end
      restaurant.save!
    end
    return {restaurant: restaurant, errors: []}
  rescue ActiveRecord::RecordInvalid => e
    {restaurant: nil, errors: e.record.errors.full_messages}
  end

  def update_restaurant(params)
    restaurant = Restaurant.find(params[:id])
    Restaurant.transaction do
      if params[:photo_ids_for_delete].present?
        photo_ids_for_delete = JSON.parse(params[:photo_ids_for_delete])
        photo_ids_for_delete.each do |photo_id|
          RestaurantPhoto.find(photo_id).destroy!
        end
      end
      photos = params[:photos].present? ? params[:photos][:files] : []
      photos.each do |file|
        restaurant.restaurant_photos.new(image: file)
      end
      restaurant.update!(restaurant_params(params))
    end
    return {restaurant: restaurant, errors: []}
  rescue ActiveRecord::RecordInvalid => e
    {restaurant: nil, errors: e.record.errors.full_messages}
  end
end
