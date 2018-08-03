FactoryBot.define do
  factory :loan do
    funded_amount { Faker::Number.decimal(4,2) }
  end
end