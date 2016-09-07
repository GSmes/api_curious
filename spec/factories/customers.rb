FactoryGirl.define do
  factory :customer do
    sequence(:first_name) { |n| "Name_#{n}" }
    sequence(:last_name) { |n| "Smith_#{n}" }
    created_at { 1.year.ago }
    updated_at { DateTime.now }
  end
end