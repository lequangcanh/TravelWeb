class PlaceCommentsController < ApplicationController
  include PlaceComments

  def create
    data = JSON.parse(params[:data])
    comment = PlaceComment.create(prepare_comment_data(data))
    if comment.save
      respond_data = respond_data_after_create(comment)
      respond_to do |format|
        format.json { render json: respond_data }
      end
    else
      respond_to do |format|
        format.all { render nothing: true, status: 403 }
      end
    end
  end
end
