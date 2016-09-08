FactoryGirl.define do
  factory :transaction do
    invoice { FactoryGirl.create(:invoice) }
    credit_card_number { rand(1000000000) }
    credit_card_expiration_date { 1.year.from_now }
    result { "success" }
    created_at { 1.year.ago }
    updated_at { DateTime.now }
  end
end