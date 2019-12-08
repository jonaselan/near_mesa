FactoryBot.define do
  factory :rating do
    user
    location
    value { rand(1..10) }
  end
end
