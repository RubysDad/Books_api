class Review < ApplicationRecord
  acts_as_paranoid

  before_validation :parse_image
  before_save :calculate_average_rating
  belongs_to :user
  belongs_to :book

  counter_culture :book

  attr_accessor :image_review

  has_attached_file :picture, styles: { medium: "300x300>", thumb: "100x100>"}
  validates_attachment :picture, presence: true
  do_not_validate_attachment_file_type :picture

  # calculate before saved in database
  def calculate_average_rating
    self.average_rating = ((self.content_rating.to_f + self.recommend_rating.to_f) / 2).round(1)
  end

  scope :reviews_by_user, -> { Review.joins(:user) }

  private

  def parse_image
    image = Paperclip.io_adapters.for(image_review)
    image.original_filename = "review_image.jpg"
    self.picture = image
  end
end

# r = Review.last
# r.delete
# re = Review.all.size => 27
# re = Review.with_deleted.all.size => 28
# Review.with_deleted.last.restore => to restore soft delete
# Review.last.really_destroy! => to really destroy it
#