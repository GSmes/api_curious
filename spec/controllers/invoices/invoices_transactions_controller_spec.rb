require 'rails_helper'

RSpec.describe Api::V1::Invoices::TransactionsController do
  describe "GET associated transactions" do
    it "retrieves the correct transactions for that invoice" do
      invoice = FactoryGirl.create(:invoice, id: 4)

      10.times do
        FactoryGirl.create(:transaction, invoice: invoice)
      end

      get :index, params: { id: 4 }

      expect(response.status).to eq(200)
      expect(assigns(:transactions).count).to eq(10)
    end

    it "does not retrieve transactions unrelated to that invoice" do
      2.times do |n|
        FactoryGirl.create(:invoice, id: "#{n+1}")
      end

      3.times do |n|
        FactoryGirl.create(:transaction, invoice: Invoice.find(2))
      end

      get :index, params: { id: 1 }

      expect(assigns(:transactions).count).to eq(0)
    end
  end
end
