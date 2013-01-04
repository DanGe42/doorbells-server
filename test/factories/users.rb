# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    display_name { Faker::Name.name }
    email { Faker::Internet.email }
    password "password"
  end
end
