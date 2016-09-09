require 'rails_helper'

RSpec.describe Api::V1::Invoices::ItemsController do
  describe "GET associated items" do
    it "retrieves the correct items for that invoice" do
      invoice = FactoryGirl.create(:invoice)

      FactoryGirl.create_list(:invoice_item, 5, invoice: invoice)

      get :index, params: { id: invoice.id }

      expect(response.status).to eq(200)
      expect(assigns(:items).count).to eq(5)
    end

    it "does not retrieve items unrelated to that invoice" do
      invoice_1 = FactoryGirl.create(:invoice, id: 1)
      invoice_2 = FactoryGirl.create(:invoice, id: 2)

      FactoryGirl.create_list(:invoice_item, 4, invoice: invoice_2)

      get :index, params: { id: 1 }

      expect(assigns(:items).count).to eq(0)
    end
  end
end
