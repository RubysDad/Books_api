module Api
  module V2
    class BookSerializer < Api::V2::ApplicationSerializer
      attributes :id, :title, :author, :image

      has_many :reviews

      def average_rating_of_book
        object.reviews.count.zero? ? 0 : object.reviews.average(:average_rating).round(1)
      end

      def content_rating_of_book
        object.reviews.count.zero? ? 0 : object.reviews.average(:content_rating).round(1)
      end

      def recommend_rating_of_book
        object.reviews.count.zero? ? 0 : object.reviews.average(:recommend_rating).round(1)
      end

      def total_reviews
        object.reviews_count
      end
    end
  end
end
