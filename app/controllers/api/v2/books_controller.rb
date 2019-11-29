# frozen string literal: true

class Api::V2::BooksController < ApplicationController
  before_action :load_book, only: :show

  def index
    @books = Book.all
    render json: Api::V2::BookSerializer.new(@books).serialized_json
  end

  def show
    books_serializer = parse_json(@book)
    render json: Api::V2::BookSerializer.new(books_serializer).serialized_json
  end

  private

  def load_book
    @book = Book.find_by(id: params[:id])

    json_response('Book cannot be found', false, {}, :not_found) if @book.blank?
  end
end
