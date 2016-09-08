require 'rails_helper'

RSpec.describe Api::V1::Transactions::InvoicesController do
  describe "GET associated invoice" do
    it "retrieves the correct invoice for that transaction" do
      transaction = FactoryGirl.create(:transaction,      
        id: 1,
        invoice: FactoryGirl.create(:invoice, id: 20)
      )
      10.times do
        FactoryGirl.create(:invoice)
      end
      
      get :show, params: { id: 1 }
      
      expect(assigns(:invoice).id).to eq(20)
    end
    
    it "does not retrieve an invoice unrelated to that transaction" do
      FactoryGirl.create(:invoice, id: 1)
      FactoryGirl.create(:invoice, id: 2)
      FactoryGirl.create(:invoice, id: 3)
      FactoryGirl.create(:transaction, 
        id: 1,
        invoice: FactoryGirl.create(:invoice)
      )
      
      get :show, params: { id: 1 }
      
      expect(assigns(:invoice)).to_not be_within(1).of(2)
    end
  end
end