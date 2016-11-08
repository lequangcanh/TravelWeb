class HomeController < ApplicationController

  def index
    @famous_places = Place.all.order('view_count desc, place_comments_count desc').limit(3)
    @recent_places = Place.all.order('created_at desc').limit(20)
    @provinces = Province.all
  end
end
