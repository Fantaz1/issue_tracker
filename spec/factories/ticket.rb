FactoryGirl.define do
  factory :ticket do
    customer_email { Random.email }
    customer_name { Random.first_name }
    body { Random.paragraphs }
    subject { Random.alphanumeric }
    department { Random.alphanumeric }
  end
end