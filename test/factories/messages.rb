# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :message do
    tag nil
    sender nil
    user nil
    contents "MyText"
  end
end
