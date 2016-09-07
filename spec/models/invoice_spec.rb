require 'rails_helper'

describe Invoice do
  it "has a valid factory" do
    invoice = FactoryGirl.create(:invoice)
    
    expect(invoice).to be_valid
  end
  
  it { should belong_to :customer }
  it { should belong_to :merchant }
  it { should validate_presence_of :status }
  it { should validate_presence_of :created_at }
  it { should validate_presence_of :updated_at }
end