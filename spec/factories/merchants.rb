FactoryGirl.define do
  factory :merchant do |f|
    f.name { Faker::Company.buzzword + " " + 
             Faker::Company.name + " " +
             Faker::Company.suffix
           }
    f.created_at { Faker::Time.between(10.years.ago, 1.year.ago) }
    f.updated_at { Faker::Time.between(1.year.ago, DateTime.now) }
  end
end