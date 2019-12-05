FactoryBot.define do
  factory :comment do
    body { "MyText" }
    location { nil }
    user { nil }
  end
end
