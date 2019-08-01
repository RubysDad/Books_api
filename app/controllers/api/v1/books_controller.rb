# frozen string literal: true

class Api::V1::BooksController < ApplicationController
  before_action :load_book, only: :show

  def index
    case params[:scope]
    when 'titles'
      @books = Book.review_titles
      json_response('Indexed Book titles and Review titles Successfully', true, { books: @books }, :ok)
    else
      @books = Book.all.includes(:reviews)
      books_serializer = parse_json(@books)
      json_response('Indexed Books Successfully', true, { books: books_serializer }, :ok)
    end
  end

  def show
    books_serializer = parse_json(@book)
    json_response('Book Found', true, { book: books_serializer }, :ok)
  end

  private

  def load_book
    @book = Book.find_by(id: params[:id])

    json_response('Book cannot be found', false, {}, :not_found) if @book.blank?
  end
end