FactoryGirl.define do
  factory :invoice do
    customer { FactoryGirl.create(:customer) }
    merchant { FactoryGirl.create(:merchant) }
    status { "Rockin' and Rollin'" }
    created_at { 1.year.ago }
    updated_at { DateTime.now }
  end
end