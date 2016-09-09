require 'rails_helper'

RSpec.describe Api::V1::Merchants::CustomersPendingInvoicesController do
  describe "GET index" do
    it "retrieves the customers with pending invoices" do
      m = FactoryGirl.create(:merchant, id: 1)
      cust_1 = FactoryGirl.create(:customer, id: 1)
      inv_1 = FactoryGirl.create(:invoice,
        customer: cust_1,
        merchant: m
      )
      inv_trans_1 = FactoryGirl.create(:transaction,
        invoice: inv_1,
        result: "failed"
      )
      cust_2 = FactoryGirl.create(:customer, id: 2)
      inv_2 = FactoryGirl.create(:invoice,
        customer: cust_2,
        merchant: m
      )
      inv_trans_2 = FactoryGirl.create(:transaction,
        invoice: inv_2,
        result: "failed"
      )
      cust_3 = FactoryGirl.create(:customer, id: 3)
      inv_3 = FactoryGirl.create(:invoice,
        customer: cust_3,
        merchant: m
      )
      inv_trans_3 = FactoryGirl.create(:transaction,
        invoice: inv_3,
        result: "failed"
      )

      get :index, params: { id: 1 }

      result = JSON.parse(response.body)
      expect(result.count).to eq(3)
      expect(OpenStruct.new(result[0]).id).to eq(1)
      expect(OpenStruct.new(result[1]).id).to eq(2)
      expect(OpenStruct.new(result[2]).id).to eq(3)
    end

    it "does not retrieve customers with no pending invoices" do
      m = FactoryGirl.create(:merchant, id: 1)
      cust_1 = FactoryGirl.create(:customer, id: 1)
      inv_1 = FactoryGirl.create(:invoice,
        merchant: m,
        customer: cust_1
      )
      inv_trans_1 = FactoryGirl.create(:transaction,
        invoice: inv_1,
        result: "failed"
      )
      cust_2 = FactoryGirl.create(:customer, id: 2)
      inv_2 = FactoryGirl.create(:invoice,
        merchant: m,
        customer: cust_2
      )
      inv_trans_2 = FactoryGirl.create(:transaction,
        invoice: inv_2,
        result: "success"
      )

      get :index, params: { id: 1 }

      result = JSON.parse(response.body)
      expect(result.count).to eq(1)
      expect(OpenStruct.new(result[0]).id).to eq(1)
    end
  end
end
