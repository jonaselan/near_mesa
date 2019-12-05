FactoryBot.define do
  factory :location do
    latitude { "MyString" }
    longitude { "MyString" }
    name { "MyString" }
    rating { "" }
    user { nil }
  end
end
