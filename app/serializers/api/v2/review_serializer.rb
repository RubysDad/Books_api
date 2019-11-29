module Api
  module V2
    class ReviewSerializer < Api::V2::ApplicationSerializer
      attributes :id, :title, :content_rating, :recommend_rating, :average_rating, :picture
      belongs_to :user
      belongs_to :book
    end
  end
end