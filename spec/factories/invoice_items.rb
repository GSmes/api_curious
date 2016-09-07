FactoryGirl.define do
  factory :invoice_item do |f|
    f.invoice { FactoryGirl.create(:invoice) }
    f.item { FactoryGirl.create(:item) }
    f.quantity { Faker::Number.number(2) }
    f.unit_price { Faker::Commerce.price }
    f.created_at { Faker::Time.between(10.years.ago, 1.year.ago) }
    f.updated_at { Faker::Time.between(1.year.ago, DateTime.now) }
  end
end
