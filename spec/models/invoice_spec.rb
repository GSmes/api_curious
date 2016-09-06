require 'rails_helper'

describe Invoice do
  it "has a valid factory" do
    invoice = FactoryGirl.create(:invoice)
    
    expect(invoice).to be_valid
  end
  
  it "is invalid without a customer id" do
    invoice = FactoryGirl.build(:invoice, customer_id: nil)
    expect(invoice).to_not be_valid
  end
  
  it "is invalid without a merchant id" do
    invoice = FactoryGirl.build(:invoice, merchant_id: nil)
    expect(invoice).to_not be_valid
  end
  
  it "is invalid without a status" do
    invoice = FactoryGirl.build(:invoice, status: nil)
    expect(invoice).to_not be_valid
  end
  
  it "is invalid without a creation timestamp" do
    invoice = FactoryGirl.build(:invoice, created_at: nil)
    expect(invoice).to_not be_valid
  end
  
  it "is invalid without an update timestamp" do
    invoice = FactoryGirl.build(:invoice, updated_at: nil)
    expect(invoice).to_not be_valid
  end
end