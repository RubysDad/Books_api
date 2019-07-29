p 'Seeding 20 books'

20.times do |n|
  Book.create!(title: Faker::Book.title,
               author: Faker::Book.author,
               image: Faker::Avatar.image)
end

p "Seeding 10 users"
10.times do |n|
  User.create!(email: Faker::Internet.email,
               password: "password")
end

p "Seeding 100 reviews"
10.times do |n|
  Review.create!(title: "Best Book",
                 content_rating: Faker::Number.between(1,10),
                 recommend_rating: Faker::Number.between(1,10),
                 user_id: Faker::Number.between(1,10),
                 book_id: Faker::Number.between(1,20))
end
