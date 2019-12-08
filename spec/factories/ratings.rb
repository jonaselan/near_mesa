FactoryBot.define do
  factory :rating do
    user
    location
    value { rand(1..10) }

    factory :invalid_rating do
      value { 0 }
    end
  end
end
