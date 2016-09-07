FactoryGirl.define do
  factory :customer do |f|
    f.first_name { Faker::Name.first_name }
    f.last_name { Faker::Name.last_name }
    f.created_at { Faker::Time.between(10.years.ago, 1.year.ago) }
    f.updated_at { Faker::Time.between(1.year.ago, DateTime.now) }
  end
end