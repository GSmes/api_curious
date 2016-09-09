require 'rails_helper'

RSpec.describe Api::V1::Invoices::CustomersController do
  describe "GET associated customer" do
    it "retrieves the correct customer for that invoice" do
      10.times do
        FactoryGirl.create(:customer)
      end

      FactoryGirl.create(
        :invoice,
        id: 1,
        customer: FactoryGirl.create(:customer, id: 20)
      )

      get :show, params: { id: 1 }

      expect(response.status).to eq(200)
      expect(assigns(:customer).id).to eq(20)
    end

    it "does not retrieve a customer unrelated to that invoice" do
      3.times do |n|
        FactoryGirl.create(:customer, id: "#{n+1}")
      end

      FactoryGirl.create(
        :invoice,
        id: 1,
        customer: FactoryGirl.create(:customer)
      )

      get :show, params: { id: 1 }

      expect(assigns(:customer)).to_not be_within(1).of(2)
    end
  end
end
