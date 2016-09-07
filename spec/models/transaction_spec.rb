require 'rails_helper'

RSpec.describe Transaction, type: :model do
  it "has a valid factory" do
    invoice = FactoryGirl.create(:customer)

    expect(invoice).to be_valid
  end

  it { should belong_to :invoice }
  it { should validate_presence_of :credit_card_number }
  it { should validate_presence_of :result }
  it { should validate_presence_of :created_at }
  it { should validate_presence_of :updated_at }
end
