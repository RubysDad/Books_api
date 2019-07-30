class NotificationMailer < ApplicationMailer
  def review(review)
    @review = review
    @user = review.user
    @subject = 'A new review was created!'

    @to = format_address('Reviewer', @user.email)
    @from = format_address('Bunch O Books', 'from@example.com')

    mail to: @to, from: @from, subject: @subject
  end

  private

  def format_address(name, email)
    address = Mail::Address.new(email)
    address.display_name = name
    address.format
  end
end