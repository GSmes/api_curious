require 'rails_helper'

RSpec.describe Item, type: :model do
  it "has a valid factory" do
    item = FactoryGirl.create(:item)
    
    expect(item).to be_valid
  end
  
  it { should validate_presence_of :name }
  it { should validate_presence_of :description }
  it { should validate_presence_of :unit_price }
  it { should validate_presence_of :merchant_id }
  it { should validate_presence_of :created_at }
  it { should validate_presence_of :updated_at }
end