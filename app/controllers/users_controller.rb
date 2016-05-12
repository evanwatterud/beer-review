class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_user

  def beers
    @beers = @user.beers
  end

  protected
  
  def correct_user
    @user = User.find(params[:id])
    unless current_user == @user
      redirect_to root_path
    end
  end
end
