FactoryBot.define do
  factory :payment do
    amount { Faker::Number.decimal(3,2) }
    loan_id nil
  end
end