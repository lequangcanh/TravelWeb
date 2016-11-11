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

  def place_params(params)
    params.require(:place).permit(:name, :description, :province_id)
  end
end
