FactoryBot.define do
  factory :trophy do
    badge
    athlete
    date { Faker::Date.backward(days: 30) }
  end
end
