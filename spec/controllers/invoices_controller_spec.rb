require "rails_helper"

RSpec.describe Api::V1::InvoicesController do
  describe "GET index" do
    it "assigns @invoices" do
      10.times do 
        FactoryGirl.create(:invoice)
      end
      get :index, format: :json
      expect(assigns(:invoices).count).to eq(10)
    end
  end
  
  describe "GET show" do
    it "retrieves the correct @invoice" do
      FactoryGirl.create(:invoice, id: 1, status: "bling")
      FactoryGirl.create(:invoice, id: 2, status: "boring")
      
      get :show, params: { id: 1, format: :json }
      expect(assigns(:invoice).status).to eq("bling")
      expect(assigns(:invoice).status).to_not eq("boring")
    end
  end
end