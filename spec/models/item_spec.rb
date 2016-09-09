require 'rails_helper'

RSpec.describe Item, type: :model do
  it "has a valid factory" do
    item = FactoryGirl.create(:item)

    expect(item).to be_valid
  end

  it { should belong_to :merchant }
  it { should have_many :invoice_items }
  it { should have_many :invoices }
  it { should validate_presence_of :name }
  it { should validate_presence_of :description }
  it { should validate_presence_of :unit_price }
  it { should validate_presence_of :merchant_id }
  it { should validate_presence_of :created_at }
  it { should validate_presence_of :updated_at }

  it "calculates best day for item" do
    item = FactoryGirl.create(:item)

    invoice_1 = FactoryGirl.create(:invoice, created_at: "2015-03-23T12:53:59.000Z")
    invoice_2 = FactoryGirl.create(:invoice, created_at: "2014-02-23T12:53:59.000Z")
    invoice_3 = FactoryGirl.create(:invoice, created_at: "2013-01-23T12:53:59.000Z")

    invoice_item_1 = FactoryGirl.create(:invoice_item, invoice: invoice_1, item: item, quantity: 1)
    invoice_item_2 = FactoryGirl.create(:invoice_item, invoice: invoice_2, item: item, quantity: 2)
    invoice_item_3 = FactoryGirl.create(:invoice_item, invoice: invoice_3, item: item, quantity: 4)

    expect(item.best_day).to eq("2013-01-23T12:53:59.000Z")
  end

  it "returns the most sold item" do
    item_1, item_2, item_3 = FactoryGirl.create_list(:item, 3)

    invoice_item_1 = FactoryGirl.create(
      :invoice_item,
      item: item_1,
      quantity: 4
    )
    invoice_item_2 = FactoryGirl.create(
      :invoice_item,
      item: item_2,
      quantity: 3
    )
    invoice_item_3 = FactoryGirl.create(
      :invoice_item,
      item: item_3,
      quantity: 9
    )
    invoice_item_4 = FactoryGirl.create(
      :invoice_item,
      item: item_1,
      quantity: 2
    )

    expect(Item.most_items(2)).to eq([item_3, item_1])
    expect(Item.most_items(3)).to eq([item_3, item_1, item_2])
  end
end
