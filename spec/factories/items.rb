FactoryGirl.define do
  factory :item do |f|
    f.name { Faker::Hacker.adjective + " " + Faker::Hipster.word }
    f.description { Faker::Lorem.paragraph }
    f.unit_price { Faker::Commerce.price }
    f.merchant { FactoryGirl.create(:merchant) }
    f.created_at { Faker::Time.between(10.years.ago, 1.year.ago) }
    f.updated_at { Faker::Time.between(1.year.ago, DateTime.now) }
  end
end