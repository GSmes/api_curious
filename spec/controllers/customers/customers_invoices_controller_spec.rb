require 'rails_helper'

RSpec.describe Api::V1::Customers::InvoicesController do
  describe "GET associated invoices" do
    it "retrieves all invoices for that customer" do
      customer = FactoryGirl.create(:customer, id: 1)
      5.times do 
        FactoryGirl.create(:invoice, customer: customer)
      end
      
      get :index, params: { id: 1 }
      
      expect(assigns(:invoices).count).to eq(5)
    end
    
    it "does not retrieve unrelated transactions" do
      customer = FactoryGirl.create(:customer, id: 1)
      10.times do
        FactoryGirl.create(:invoice)
      end
      
      get :index, params: { id: 1 }
      
      expect(assigns(:invoices).count).to eq(0)
    end
  end
end