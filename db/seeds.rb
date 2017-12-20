100.times do |n|

  name = Faker::Name.name
  email = Faker::Internet.email
  password = "password"

  u = User.create!(
      name: name,
      email: email,
      password: password,
      password_confirmation: password
  )

  u.confirm
  
end

users = User.order(:created_at).take(6)
50.times do
  content = Faker::Lorem.sentence(5)
  users.each { |user| user.posts.create!(content: content) }
end

user = User.first
user.friends = users[1..5]
