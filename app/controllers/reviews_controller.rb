class ReviewsController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_user, only: [:edit, :update, :destroy]

  def create
    @beer = Beer.find(params[:beer_id])
    @review = Review.new(review_params)
    @review.user_id = current_user.id
    @review.beer = @beer
    @reviews = @beer.reviews.page(params[:id])

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

  def upvote
    vote_handling(1)
  end

  def downvote
    vote_handling(-1)
  end

  protected
  def review_params
    params.require(:review).permit(:body)
  end

  def vote_handling(num)
    @review = Review.find(params[:id])
    vote = Vote.find_by(user: current_user, review: @review)
    if vote
      if vote.value == -(num)
        vote.update_attributes(value: num)
      else
        vote.destroy
      end
    else
      Vote.create(value: num, user: current_user, review: @review)
    end
    redirect_to beer_path(@review.beer)
  end

  def correct_user
    @review = Review.find(params[:id])
    unless (current_user.reviews.include?(@review) || current_user.role == 'admin')
      redirect_to root_path
    end
  end
end
