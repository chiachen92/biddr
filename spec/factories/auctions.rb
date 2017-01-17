FactoryGirl.define do
  factory :auction do
    title { Faker::Book.title }
    details { Faker::Lorem.paragraph }
    reserve_price { rand(1000) }
    user 
  end
end
