require 'rails_helper'

RSpec.describe Api::V1::Customers::TransactionsController do
  describe "GET associated transactions" do
    it "retrieves all transactions for that customer" do
      customer = FactoryGirl.create(:customer, id: 1)
      invoice_1 = FactoryGirl.create(:invoice,
        id: 1, 
        customer: customer
      )
      transaction_1 = FactoryGirl.create(:transaction, 
        invoice: invoice_1,
        result: "fail"
      )
      transaction_2 = FactoryGirl.create(:transaction,
        invoice: invoice_1
      )
      invoice_2 = FactoryGirl.create(:invoice,
        id: 2, 
        customer: customer
      )
      transaction_3 = FactoryGirl.create(:transaction,
        invoice: invoice_2
      )
      
      get :index, params: { id: 1 }
      
      expect(assigns(:transactions).count).to eq(3)
    end
    
    it "does not retrieve unrelated transactions" do
      customer = FactoryGirl.create(:customer, id: 1)
      10.times do
        FactoryGirl.create(:transaction)
      end
      
      get :index, params: { id: 1 }
      
      expect(assigns(:transactions).count).to eq(0)
    end
  end
end