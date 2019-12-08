FactoryBot.define do
  factory :review do
    comment { Faker::Lorem.paragraph(sentence_count: 5) }
    rating { rand(1..10) }
    location
    user

    factory :invalid_review do
      comment { '' }
      rating { 0 }
    end
  end
end
