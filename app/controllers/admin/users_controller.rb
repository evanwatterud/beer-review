class Admin::UsersController < ApplicationController
  before_action :check_admin

  def index
    @users = User.all
  end

  protected

  def check_admin
    unless user_signed_in? && current_user.admin?
      raise ActionController::RoutingError.new('Not Found')
    end
  end
end
