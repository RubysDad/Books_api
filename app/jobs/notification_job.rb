class NotificationJob < ApplicationJob
  queue_as :default

  def perform(review)
    NotificationMailer.review(review).deliver
  end
end
