FactoryBot.define do
  factory :location do
    latitude { Faker::Address.latitude }
    longitude { Faker::Address.longitude }
    name { Faker::Address.community }
    rating { rand(1..5) }
    user
  end
end
