class ReviewsController < ApplicationController
  def index
    @reviews = Review.all
  end

  def new
    @review = Review.new
    @list = List.find(params[:list_id])
  end

  def create
    @review = Review.new(review_params)
    @list = List.find(params[:list_id])
    @review.list = @list
    if @review.save
      redirect_to list_path(@list), status: :see_other
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @review = Review.find(params[:id])
  end

  private

  def review_params
    params.require(:review).permit([:content])
  end
end
