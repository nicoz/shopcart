FactoryGirl.define do
  factory :user do
    sequence :name do |n|
      "Person #{n}"
    end
    sequence :email do |n|
      "email#{n}@factory.com"
    end
    
    password "Nicolas1"
    password_confirmation "Nicolas1"

    factory :admin do
      admin true
    end
  end
  
  factory :general do
    name    "Test"
    title   "Test"
    slogan  "Test"
  end
end
