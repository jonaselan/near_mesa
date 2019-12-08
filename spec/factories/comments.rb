FactoryBot.define do
  factory :comment do
    body { Faker::Lorem.paragraph(sentence_count: 5) }
    location
    user

    factory :invalid_comment do
      body { '' }
    end
  end
end
