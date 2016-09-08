require 'rails_helper'

RSpec.describe Api::V1::InvoiceItemsController do
  describe "GET index" do
    it "assigns @invoice_items" do
      10.times do
        FactoryGirl.create(:invoice_item)
      end
      get :index
      expect(assigns(:invoice_items).count).to eq(10)
    end
  end
  
  describe "GET show" do
    it "retrieves the correct @invoice_item" do
      FactoryGirl.create(:invoice_item, id: 1, unit_price: 9.99)
      FactoryGirl.create(:invoice_item, id: 2, unit_price: 4.99)
      
      get :show, params: { id: 1 }
      expect(assigns(:invoice_item).unit_price).to eq(9.99)
      expect(assigns(:invoice_item).unit_price).to_not eq(4.99)
    end
  end
end