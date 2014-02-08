FactoryGirl.define do
  sequence(:email) {|n| "test#{n}@test.com" }

  factory :ticket do
    customer_email { generate(:email) }
    customer_name { Faker::Name.first_name }
    body { Faker::Lorem.sentence }
    subject { Faker::Lorem.word }
    department { Faker::Lorem.word }
  end
end