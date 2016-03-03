class ReviewsController < ApplicationController
  before_action :require_login, only: [:create]

  def create
    @business = Business.find params[:business_id]
    @review = @business.reviews.new review_params.merge!(user: current_user)
    if @review.save
      flash[:notice] = "Your review was posted!"
      redirect_to business_path(@business)
    else
      flash.now[:error] = "Oh no! There's something wrong with your review."
      render 'businesses/show'
    end
  end

  def index
    @reviews = Review.limit 10
  end

  private

    def review_params
      params.require(:review).permit(:body)
    end
end
