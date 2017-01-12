FactoryGirl.define do
  factory :auction do
    title { Faker::Book.title }
    details { Faker::Lorem.paragraph }
    ends_on { Faker::Date.forward(30) }
    reserve_price { rand(1000) }
  end
end
