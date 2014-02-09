FactoryGirl.define do
  factory :user do
    name                  { Random.firstname }
    password              "12345678"
    password_confirmation{ |u| u.password }
  end
end

