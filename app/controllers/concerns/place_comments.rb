module PlaceComments
  extend ActiveSupport::Concern

  def respond_data_after_create(comment)
    user_json = User.find(comment.user_id).as_json(only: [:id, :name, :email])
    comment_json = comment.as_json(only: [:id, :content, :user_id, :created_at])
    {user: user_json, comment: comment_json}
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
