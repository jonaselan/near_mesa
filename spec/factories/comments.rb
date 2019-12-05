FactoryBot.define do
  factory :comment do
    body { Faker::Lorem.paragraph(sentence_count: 5) }
    location
    user
  end
end
