FactoryGirl.define do
  factory :user do
    name     "Nicolas Zuasti"
    email    "nicozuasti@gmail.com"
    password "Nicolas1"
    password_confirmation "Nicolas1"
  end
  
  factory :general do
    name    "Test"
    title   "Test"
    slogan  "Test"
  end
end
