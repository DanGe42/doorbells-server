# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :tag do
    user
    location { Faker::Address.street_address }
  end
end
