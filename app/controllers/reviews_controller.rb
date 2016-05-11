class ReviewsController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_user, only: [:edit, :update, :destroy]

  def create
    @beer = Beer.find(params[:beer_id])
    @review = Review.new(review_params)
    @review.user_id = current_user.id
    @review.beer = @beer
    @reviews = @beer.reviews

    if @review.save
      redirect_to beer_path(@beer)
    else
      render "beers/show.html.erb"
    end
  end

  def edit
    @beer = Beer.find(params[:beer_id])
    @review = Review.find(params[:id])
  end

  def update
    @review = Review.find(params[:id])
    @beer = Beer.find(params[:beer_id])
    if @review.update_attributes(review_params)
      redirect_to beer_path(@beer), notice: "Successfully updated review."
    else
      render 'edit'
    end
  end

  def destroy
    Review.find(params[:id]).destroy
    redirect_to beer_path(Beer.find(params[:beer_id])), notice: "Successfully deleted review."
  end

  protected
  def review_params
    params.require(:review).permit(:body)
  end

  def correct_user
    @review = Review.find(params[:id])
    unless current_user.reviews.include?(@review)
      redirect_to root_path
    end
  end
end
