require 'rails_helper'

RSpec.describe Customer, type: :model do
  it "has a valid factory" do
    customer = FactoryGirl.create(:customer)

    expect(customer).to be_valid
  end

  it { should have_many :invoices }
  it { should have_many :transactions }
  it { should validate_presence_of :first_name }
  it { should validate_presence_of :last_name }
  it { should validate_presence_of :created_at }
  it { should validate_presence_of :updated_at }
end
