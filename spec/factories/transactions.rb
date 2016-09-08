FactoryGirl.define do
  factory :transaction do
    invoice { FactoryGirl.create(:invoice) }
    credit_card_number { rand(10 ** 16) }
    result { ['success', 'failed'].sample }
    created_at { 1.year.ago }
    updated_at { DateTime.now }
  end
end
