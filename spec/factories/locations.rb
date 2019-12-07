FactoryBot.define do
  factory :location do
    latitude { Faker::Address.latitude }
    longitude { Faker::Address.longitude }
    name { Faker::Address.community }
    user

    factory :invalid_location do
      name { '' }
    end
  end
end
