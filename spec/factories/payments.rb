FactoryBot.define do
  factory :payments do
    amount { Faker::Number.decimal(3,2) }
    loan_id nil
  end
end