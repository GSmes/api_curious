require 'rails_helper'

RSpec.describe Api::V1::InvoiceItems::RandomController do
  describe "GET random" do
    it "retrieves a random @invoice_item" do
      500.times do 
        FactoryGirl.create(:invoice_item)
      end
      get :show, params: { format: :json }
      first_random_invoice_item = assigns(:invoice_item)
      
      get :show, params: { format: :json }
      second_random_invoice_item = assigns(:invoice_item)
      
      expect(first_random_invoice_item).to_not eq(second_random_invoice_item)
    end
  end
end