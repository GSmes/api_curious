require 'rails_helper'

RSpec.describe Merchant, type: :model do
  it "has a valid factory" do
    merchant = FactoryGirl.create(:merchant)

    expect(merchant).to be_valid
  end

  it { should have_many :items }
  it { should have_many :invoices }
  it { should validate_presence_of :name }
  it { should validate_presence_of :created_at }
  it { should validate_presence_of :updated_at }
end
