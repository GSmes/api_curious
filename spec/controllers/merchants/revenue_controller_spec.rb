require 'rails_helper'

RSpec.describe Api::V1::Merchants::RevenueController do
  describe "GET most_revenue?quantity=x" do
    it "retrieves the top x merchants by total revenue" do
      merchant_1 = FactoryGirl.create(:merchant, id: 1)
      merchant_1_items = []
      25.times do
        merchant_1_items << FactoryGirl.create(:item, merchant: merchant_1)
      end
      customer = FactoryGirl.create(:customer, id: 1)
      merchant_1_invoices = []
      5.times do |n|
        merchant_1_invoices << FactoryGirl.create(:invoice,
          id: n,
          customer: customer,
          merchant: merchant_1
        )
      end
      merchant_1_items.each do |item|
        FactoryGirl.create(:invoice_item,
          invoice: merchant_1_invoices.sample,
          item: item
        )
      end
      merchant_2 = FactoryGirl.create(:merchant, id: 2)
      merchant_2_item = FactoryGirl.create(:item, merchant: merchant_2)
      merchant_2_invoice = FactoryGirl.create(:invoice,
        id: 1501,
        customer: customer,
        merchant: merchant_2
      )
      FactoryGirl.create(:invoice_item,
        invoice: merchant_2_invoice,
        item: merchant_2_item
      )
      merchant_3 = FactoryGirl.create(:merchant, id: 3)

      get :index, params: { quantity: 3 }

      result = JSON.parse(response.body)
      expect(OpenStruct.new(result[0]).id).to eq(1)
    end
  end

  describe "GET /:id/revenue" do
    it "returns the total revenue for that merchant across all transactions" do
      merchant = FactoryGirl.create(:merchant, id: 1)

      item = FactoryGirl.create(:item, merchant: merchant, unit_price: 100.00)

      invoice_1 = FactoryGirl.create(:invoice, merchant: merchant)
      invoice_2 = FactoryGirl.create(:invoice, merchant: merchant)

      FactoryGirl.create(
        :invoice_item,
        invoice: invoice_1,
        item: item,
        quantity: 3,
        unit_price: item.unit_price
      )
      FactoryGirl.create(
        :invoice_item,
        invoice: invoice_2,
        item: item,
        quantity: 4,
        unit_price: item.unit_price
      )

      FactoryGirl.create(:transaction, invoice: invoice_1, result: "success")
      FactoryGirl.create(:transaction, invoice: invoice_2, result: "success")

      get :show, params: { id: 1 }

      result = JSON.parse(response.body)
      expect(result).to eq({"revenue" => "700.00"})
    end
  end

  describe "GET revenue?date=x" do
    it "retrieves the total revenue across date x for all merchants" do
      m1 = FactoryGirl.create(:merchant)
      m1_item = FactoryGirl.create(:item, merchant: m1)
      m1_inv = FactoryGirl.create(:invoice, merchant: m1, created_at: "2016-09-09 02:55:05")
      m1_ii = FactoryGirl.create(:invoice_item,
        invoice: m1_inv, item: m1_item, quantity: 10, unit_price: 10)
      m1_it = FactoryGirl.create(:transaction,
        invoice: m1_inv, result: "success")

      m2 = FactoryGirl.create(:merchant)
      m2_item = FactoryGirl.create(:item, merchant: m2)
      m2_inv = FactoryGirl.create(:invoice, merchant: m2, created_at: "2016-09-09 02:55:05")
      m2_ii = FactoryGirl.create(:invoice_item,
        invoice: m2_inv, item: m2_item, quantity: 5, unit_price: 5)
      m2_it = FactoryGirl.create(:transaction,
        invoice: m2_inv, result: "success")

      get :date, params: { date: "2016-09-09 02:55:05" }

      result = JSON.parse(response.body)
      expect(result).to eq({"total_revenue" => "125.00"})
    end
  end

  describe "GET :id/revenue?date=x" do
    it "retrieves the total revenue across date x for that merchant" do
      m = FactoryGirl.create(:merchant, id: 1)
      item = FactoryGirl.create(:item, merchant: m)
      invoice_1 = FactoryGirl.create(:invoice, merchant: m, created_at: "2016-09-09 02:55:05")
      invoice_item_1 = FactoryGirl.create(:invoice_item,
        invoice: invoice_1, item: item, quantity: 10, unit_price: 10)
      invoice_transaction_1 = FactoryGirl.create(:transaction,
        invoice: invoice_1, result: "success")
      invoice_2 = FactoryGirl.create(:invoice, merchant: m, created_at: "2016-09-09 02:55:05")
      invoice_item_2 = FactoryGirl.create(:invoice_item,
        invoice: invoice_2, item: item, quantity: 5, unit_price: 5)
      invoice_transaction_2 = FactoryGirl.create(:transaction,
        invoice: invoice_2, result: "success")

      get :show, params: { id: 1, date: "2016-09-09 02:55:05" }

      result = JSON.parse(response.body)
      expect(result).to eq({"revenue" => "125.00"})
    end
  end
end
