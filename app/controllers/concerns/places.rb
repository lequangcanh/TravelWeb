module Places
  extend ActiveSupport::Concern

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

  def place_params(params)
    params.require(:place).permit(:name, :description, :province_id)
  end
end
