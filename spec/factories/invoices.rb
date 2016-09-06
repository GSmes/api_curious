FactoryGirl.define do
  factory :invoice do |f|
    f.customer_id { Faker::Number.between(1, 500) }
    f.merchant_id { Faker::Number.between(1, 500) }
    f.status { Faker::Hipster.word }
    f.created_at { Faker::Date.between(10.years.ago, 1.year.ago) }
    f.updated_at {Faker::Date.between(1.year.ago, Date.today) }
  end
end