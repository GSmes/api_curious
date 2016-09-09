require 'rails_helper'

RSpec.describe Customer, type: :model do
  it "has a valid factory" do
    customer = FactoryGirl.create(:customer)

    expect(customer).to be_valid
  end

  it { should have_many :invoices }
  it { should have_many :transactions }
  it { should have_many :merchants }
  it { should validate_presence_of :first_name }
  it { should validate_presence_of :last_name }
  it { should validate_presence_of :created_at }
  it { should validate_presence_of :updated_at }

  xit "returns the customer's favorite merchant" do
    customer = FactoryGirl.create(:customer)

    merchant_1, merchant_2 = create_list(:merchant, 2)

    3.times do |i|
      if i < 2
        invoice = FactoryGirl.create(:invoice,
                                     customer: customer,
                                     merchant: merchant_1)
        FactoryGirl.create(:transaction, invoice: invoice)
      else
        invoice = FactoryGirl.create(:invoice,
                                     customer: customer,
                                     merchant: merchant_2)
        FactoryGirl.create(:transaction, invoice: invoice)
      end
    end

    expect(customer.favorite_merchant).to eq(merchant_1)
  end
end
