class PlaceCommentsController < ApplicationController
  def create
    data = JSON.parse(params[:data])
    comment = PlaceComment.create(prepare_comment_data(data))
    if comment.save
      user_json = User.find(comment.user_id).as_json(only: [:id, :name, :email])
      comment_json = comment.as_json(only: [:id, :content, :user_id, :created_at])
      respond_data = {user: user_json, comment: comment_json}
      respond_to do |format|
        format.json { render json: respond_data }
      end
    else
      respond_to do |format|
        format.all { render nothing: true, status: 403 }
      end
    end
  end

  private

  def comment_params(params)
    params.require(:comment).permit(:user_id, :place_id, :content)
  end

  def prepare_comment_data(data)
    comment_data = {}
    data.each { |i| comment_data[i['name'].to_sym] = i['value'] }
    comment_data.slice(:place_id, :content, :user_id)
  end
end
