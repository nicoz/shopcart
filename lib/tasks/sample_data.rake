namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    User.create!(name: "Nicolas Zuasti",
                 email: "nicozuasti@gmail.com",
                 password: "Nicolas1",
                 password_confirmation: "Nicolas1")
    99.times do |n|
      name  = Faker::Name.name
      email = "example-#{n+1}@shopcart.com"
      password  = "Nicolas#{n+1}"
      User.create!(name: name,
                   email: email,
                   password: password,
                   password_confirmation: password)
    end
  end
end
