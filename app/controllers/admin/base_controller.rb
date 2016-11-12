class Admin::BaseController < ApplicationController
  layout 'admin/layouts/admin_panel'
  before_action :user_admin

  private
  def user_admin
    redirect_to root_url if current_user.nil? || !current_user.is_admin?
  end
end
