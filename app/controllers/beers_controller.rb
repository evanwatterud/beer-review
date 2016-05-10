class BeersController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :correct_user, only: [:edit, :update, :destroy]

  def index
    @beers = Beer.all
  end

  def new
    @beer = Beer.new
  end

  def show
    @beer = Beer.find(params[:id])
  end

  def create
    @beer = Beer.new(beer_params)
    @beer.user_id = current_user.id

    if @beer.save
      redirect_to @beer, notice: "Successfully added #{@beer.name}."
    else
      render :new
    end
  end

  def edit
    @beer = Beer.find(params[:id])
    unless current_user.beers.include?(@beer)
      raise ActionController::RoutingError.new("Not Found")
    end
  end

  def update
    @beer = Beer.find(params[:id])
    if @beer.update_attributes(beer_params)
      redirect_to user_beers_path(current_user.id), notice: "Successfully updated beer."
    else
      render 'edit'
    end
  end

  def destroy
    Beer.find(params[:id]).destroy
    redirect_to user_beers_path(current_user.id), notice: 'Successfully deleted beer.'
  end

  protected
  def beer_params
    params.require(:beer).permit(:name, :brewer, :style, :brewing_country, :abv)
  end

  def correct_user
    @beer = Beer.find(params[:id])
    unless current_user.beers.include?(@beer)
      redirect_to root_path
    end
  end
end
