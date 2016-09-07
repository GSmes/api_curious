FactoryGirl.define do
  factory :invoice do |f|
    f.customer { FactoryGirl.create(:customer) }
    f.merchant { FactoryGirl.create(:merchant) }
    f.status { Faker::Hacker.ingverb }
    f.created_at { Faker::Time.between(10.years.ago, 1.year.ago) }
    f.updated_at {Faker::Time.between(1.year.ago, DateTime.now) }
  end
end