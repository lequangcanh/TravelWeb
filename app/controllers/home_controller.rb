class HomeController < ApplicationController

  def index
    @famous_places = Place.all.order('view_count desc, place_comments desc')
  end
end
