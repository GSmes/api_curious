require 'rails_helper'

RSpec.describe Api::V1::Merchants::FavoriteCustomersController do
  describe "GET show" do
    it "retrieves the customer with the most total number of successful transactions" do
      m = FactoryGirl.create(:merchant, id: 1)
      cust_1 = FactoryGirl.create(:customer, id: 1)
      inv_1 = FactoryGirl.create(:invoice,
        customer: cust_1,
        merchant: m,
      )
      inv_trans_1 = FactoryGirl.create(:transaction,
        invoice: inv_1,
        result: "success"
      )
      cust_2 = FactoryGirl.create(:customer, id: 2)
      inv_2 = FactoryGirl.create(:invoice,
        customer: cust_2,
        merchant: m
      )
      inv_trans_2 = FactoryGirl.create(:transaction,
        invoice: inv_2,
        result: "success"
      )
      inv_3 = FactoryGirl.create(:invoice,
        customer: cust_2,
        merchant: m
      )
      inv_trans_3 = FactoryGirl.create(:transaction,
        invoice: inv_3,
        result: "success"
      )

      get :show, params: { id: 1 }

      result = JSON.parse(response.body)
      expect(OpenStruct.new(result).id).to eq(2)
    end
  end
end
