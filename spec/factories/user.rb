FactoryGirl.define do
  factory :user do
    name                  { Faker::Lorem.word }
    password              "12345678"
    password_confirmation{ |u| u.password }
  end
end

