require 'rails_helper'

RSpec.describe Api::V1::Merchants::InvoicesController do
  describe "GET all related invoices" do
    it "retrieves all invoices related to that merchant" do
      merchant = FactoryGirl.create(:merchant, id: 1)
      10.times do
        FactoryGirl.create(:invoice, merchant: merchant)
      end
      
      get :index, params: { id: 1 }
      
      expect(assigns(:invoices).count).to eq(10)
    end
    
    it "does not retrieve invoices unrelated to that merchant" do
      FactoryGirl.create(:merchant, id: 1)
      10.times do
        FactoryGirl.create(:invoice)
      end
      
      get :index, params: { id: 1 }
      
      expect(assigns(:invoices).count).to eq(0)
    end
  end
end