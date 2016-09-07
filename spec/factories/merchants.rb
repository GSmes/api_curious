FactoryGirl.define do
  factory :merchant do |f|
    sequence(:name) { |n| "Merchant ##{n}" }
    created_at { 1.year.ago }
    updated_at { DateTime.now }
  end
end