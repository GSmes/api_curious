require 'rails_helper'

RSpec.describe Api::V1::Invoices::InvoiceItemsController do
  describe "GET associated invoice_items" do
    it "retrieves the correct invoice_items for that invoice" do
      invoice = FactoryGirl.create(:invoice, id: 4)

      10.times do
        FactoryGirl.create(:invoice_item, invoice: invoice)
      end

      get :index, params: { id: 4 }

      expect(response.status).to eq(200)
      expect(assigns(:invoice_items).count).to eq(10)
    end

    it "does not retrieve invoice_items unrelated to that invoice" do
      2.times do |n|
        FactoryGirl.create(:invoice, id: "#{n+1}")
      end

      3.times do |n|
        FactoryGirl.create(:invoice_item, invoice: Invoice.find(2))
      end

      get :index, params: { id: 1 }

      expect(assigns(:invoice_items).count).to eq(0)
    end
  end
end
