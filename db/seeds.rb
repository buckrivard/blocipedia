User.destroy_all
Wiki.destroy_all

CURRENT_TIME = Time.now

def some_time_ago
	CURRENT_TIME - rand(200..20_000).minutes
end

5.times do
  User.create(
     email: Faker::Internet.email,
     password: Faker::Internet.password,
     confirmed_at: Time.now
  )
end

users = User.all

50.times do
 	wiki = Wiki.create(
 		title:  "#{Faker::Hacker.noun.upcase}!",
 		body:   Faker::Hacker.say_something_smart,
     user: users.sample
 	)
	wiki.update(created_at: some_time_ago)
end

User.create(email: 'buckrivard@gmail.com', password: 'helloworld', confirmed_at: Time.now)

puts "Seed finished"
puts "#{User.count} users created."
puts "#{Wiki.count} wikis created."
