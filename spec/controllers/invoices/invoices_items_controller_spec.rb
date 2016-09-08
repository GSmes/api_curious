require 'rails_helper'

RSpec.describe Api::V1::Invoices::ItemsController do
  describe "GET associated items" do
    xit "retrieves the correct items for that invoice" do
      # need to figure out how to write this test
      invoice = FactoryGirl.create(:invoice, id: 4)

      10.times do
        FactoryGirl.create(:item, invoice: invoice)
      end

      get :index, params: { id: 4 }

      expect(response.status).to eq(200)
      expect(assigns(:items).count).to eq(10)
    end

    xit "does not retrieve items unrelated to that invoice" do
      # need to figure out how to write this test
      2.times do |n|
        FactoryGirl.create(:invoice, id: "#{n+1}")
      end

      3.times do |n|
        FactoryGirl.create(:item, invoice: Invoice.find(2))
      end

      get :index, params: { id: 1 }

      expect(assigns(:items).count).to eq(0)
    end
  end
end
