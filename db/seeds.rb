require 'random_data'


50.times do
	wiki = Wiki.create!(
		title:  RandomData.random_sentence,
		body:   RandomData.random_paragraph,
		private: false,
	)

	wiki.update_attribute(:created_at, rand(10.minutes .. 1.year).ago)
end



puts "Seed finished"
puts "#{Wiki.count} wikis created."
