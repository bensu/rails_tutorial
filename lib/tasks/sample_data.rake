namespace :db do
	desc "Fill database with sample data"
	task populate: :environment do
		User.create!(name: "Sebastian Bensusan",
					 email: "sbensu@gmail.com",
					 password: "carrick4800",
					 password_confirmation: "carrick4800",
					 admin: true)
		99.times do |n|
			name = Faker::Name.name
			email = "example-#{n+1}@rails.org"
			password = "password"
			User.create!(name: name,
						email: email,
						password: password,
						password_confirmation: password)
		end
	end
end