FactoryGirl.define do
  factory :item do
    sequence(:name) { |n| "Import_##{n}" }
    sequence(:description) { |n| "Description of Item ##{n}" }
    unit_price { rand(10000)/100 }
    merchant { FactoryGirl.create(:merchant) }
    created_at { 1.year.ago }
    updated_at { DateTime.now }
  end
end