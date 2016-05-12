class Admin::UsersController < ApplicationController
  before_action :check_admin

  def index
    @users = User.all
  end

  def destroy
    user = User.find(params[:id])
    if user == current_user
      flash[:notice] = "You can't delete yourself!"
    elsif user.role == 'admin'
      flash[:notice] = "You can't delete other admins!"
    else
      User.find(params[:id]).destroy
      flash[:notice] = "Successfully deleted user."
    end
    redirect_to admin_users_path
  end

  protected

  def check_admin
    unless user_signed_in? && current_user.admin?
      raise ActionController::RoutingError.new('Not Found')
    end
  end
end
