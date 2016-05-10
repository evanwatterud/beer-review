class ReviewsController < ApplicationController
  def create
    @beer = Beer.find(params[:beer_id])
    @review = Review.new(review_params)
    @review.user_id = current_user.id
    @review.beer = @beer

    if @review.save
      redirect_to beer_path(@beer)
    else
      redirect_to beer_path(@beer)
    end
  end

  protected
  def review_params
    params.require(:review).permit(:body)
  end
end
