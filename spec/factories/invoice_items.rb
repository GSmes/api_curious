FactoryGirl.define do
  factory :invoice_item do
    invoice { FactoryGirl.create(:invoice) }
    item { FactoryGirl.create(:item) }
    quantity { rand(10) }
    unit_price { item.unit_price }
    created_at { 1.year.ago }
    updated_at { DateTime.now }
  end
end
