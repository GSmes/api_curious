require 'rails_helper'

RSpec.describe InvoiceItem, type: :model do
  it "has a valid factory" do
    invoice_item = FactoryGirl.create(:invoice_item)

    expect(invoice_item).to be_valid
  end

  it { should belong_to :invoice }
  it { should validate_presence_of :invoice_id }
  it { should belong_to :item }
  it { should validate_presence_of :item_id }
  it { should validate_presence_of :quantity }
  it { should validate_presence_of :unit_price }
  it { should validate_presence_of :created_at }
  it { should validate_presence_of :updated_at }
end
