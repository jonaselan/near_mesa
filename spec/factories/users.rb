FactoryBot.define do
  factory :user do
    email { Faker::Internet.unique.email }
    password { 'password' }

    factory :invalid_user do
      email { '' }
    end
  end
end
