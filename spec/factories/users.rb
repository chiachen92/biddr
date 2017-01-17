FactoryGirl.define do
  factory :user do
    first_name { Faker::Book.title }
    last_name { Faker::Lorem.paragraph }
    email {Faker::Internet.email}
    password { "123"}
  end
end
