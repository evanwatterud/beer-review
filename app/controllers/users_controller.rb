class UsersController < ApplicationController
  before_action :authenticate_user!

  def beers
    user = User.find(params[:id])
    @beers = user.beers
  end
end
