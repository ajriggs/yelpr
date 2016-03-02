class BusinessesController < ApplicationController
  def index
    @businesses = Business.limit 10
  end

  def show
    @business = Business.find params[:id]
    @review = Review.new
  end

  def new
    @business = Business.new
  end

  def create
    @business = Business.new business_params
    if @business.save
      flash[:notice] = 'You added a new business!'
      redirect_to root_path
    else
      flash[:error] = 'Your submission contained validation errors. Please try again.'
      render :new
    end
  end

  def search
    @search_results = Business.search_by_name params[:query]
  end

  private

  def business_params
    params.require(:business).permit :name
  end
end
