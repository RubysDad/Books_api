

class Api::V1::ReviewsController < ApplicationController
  before_action :load_book, only: :index
  before_action :load_review, only: %w[show update destroy restore]
  before_action :authenticate_with_token!, only: %w[create update destroy restore]

  def index
    @reviews = @book.reviews.includes(:user)
    reviews_serializer = parse_json(@reviews)
    json_response('Indexed Reviews Successfully', true, { reviews: reviews_serializer }, :ok)
  end

  def show
    reviews_serializer = parse_json(@review)
    json_response('Review Found', true, { review: reviews_serializer}, :ok)
  end

  def create
    review = Review.new(review_params)
    review.user_id = current_user.id
    review.book_id = params[:book_id]

    if review.save
      reviews_serializer = parse_json(review)
      json_response('Created Review Successfully', true, { review: reviews_serializer }, :ok)
      NotificationJob.perform_later(review)
    else
      json_response('Could not create review', false, {}, :unprocessable_entity)
    end
  end

  def update
    return json_response('Unauthorized Access', false, {}, :unauthorized) if invalid_user(@review.user)

    if @review.update(review_params)
      reviews_serializer = parse_json(@review)
      json_response('Updated Review Successfully', true, { review: reviews_serializer}, :ok)
    else
      json_response('Could not Update Review', false, {}, :unprocessable_entity)
    end
  end

  def destroy
    return json_response('Unauthorized Access', false, {}, :unauthorized) if invalid_user(@review.user)

    if params[:type] == 'indefinitely'
      @review.really_destroy!
      json_response('Deleted Review Successfully', true, {}, :ok)
    else
      soft_delete_review
    end
  end

  private

  def load_book
    @book = Book.find_by(id: params[:book_id])

    json_response("Cannot find book", false, {}, :not_found) if @book.blank?
  end

  def load_review
    @review = Review.find_by(id: params[:id])

    json_response("Cannot find review", false, {}, :not_found) if @review.blank?
  end

  def review_params
    params.require(:review).permit(:title, :content_rating, :recommend_rating, :image_review)
  end

  def soft_delete_review
    if @review.destroy
      json_response('Soft-Deleted Review Successfully', true, {}, :ok)
    else
      json_response('Could not Delete Review', false, {}, :unprocessable_entity)
    end
  end

  def restore
    @review.restore
    json_response('Deleted Review Restored Successfully', true, {}, :ok)
  end
end