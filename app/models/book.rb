class Book < ApplicationRecord
  has_many :reviews

  scope :book_reviews, -> { Book.joins(:reviews) }
  scope :review_titles, -> { Book.left_joins(:reviews).select('books.id, books.title, reviews.title, reviews.average_rating') }
end

