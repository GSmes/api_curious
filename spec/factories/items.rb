FactoryGirl.define do
  factory :item do
    sequence(:name) { |n| "Import_##{n}" }
    sequence(:description) { |n| "Description of Item ##{n}" }
    unit_price { (rand(100..1000)/7).to_f.round(2) }
    merchant { FactoryGirl.create(:merchant) }
    created_at { 1.year.ago }
    updated_at { DateTime.now }
  end
end