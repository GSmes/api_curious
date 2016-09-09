require 'rails_helper'

RSpec.describe Api::V1::Merchants::RevenueController do
  describe "GET most_revenue?quantity=x" do
    it "retrieves the top x merchants by total revenue" do
      merchant_1 = FactoryGirl.create(:merchant, id: 1)
      merchant_1_items = []
      20.times do 
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
      expect(OpenStruct.new(result[1]).id).to eq(2)
      expect(OpenStruct.new(result[2]).id).to eq(3)
    end
  end
  
  describe "GET /:id/revenue" do
    it "returns the total revenue for that merchant across all transactions" do
      m = FactoryGirl.create(:merchant, id: 1)
      item = FactoryGirl.create(:item, merchant: m, unit_price: 100)
      c = FactoryGirl.create(:customer, id: 1)
      invoice_1 = FactoryGirl.create(:invoice, customer: c, merchant: m)
      invoice_2 = FactoryGirl.create(:invoice, customer: c, merchant: m)
      FactoryGirl.create(:invoice_item,
        invoice: invoice_1,
        item: item,
        quantity: 2,
        unit_price: 100.00
      )
      FactoryGirl.create(:invoice_item,
        invoice: invoice_2,
        item: item,
        quantity: 3,
        unit_price: 100.00
      )
      
      get :show, id: 1
      expect(JSON.parse(response.body)).to eq(500.0)
    end
  end
  
  describe "GET revenue?date=x" do
    it "retrieves the total revenue across date x for all merchants" do
      m1 = FactoryGirl.create(:merchant)
      m1_item = FactoryGirl.create(:item, merchant: m1)
      m1_inv = FactoryGirl.create(:invoice, merchant: m1)
      m1_ii = FactoryGirl.create(:invoice_item, 
        invoice: m1_inv, item: m1_item, quantity: 10, unit_price: 10)
      m1_it = FactoryGirl.create(:transaction, 
        invoice: m1_inv, updated_at: "3/3/2003", result: "success")
      m2 = FactoryGirl.create(:merchant)
      m2_item = FactoryGirl.create(:item, merchant: m2)
      m2_inv = FactoryGirl.create(:invoice, merchant: m2)
      m2_ii = FactoryGirl.create(:invoice_item, 
        invoice: m2_inv, item: m2_item, quantity: 5, unit_price: 5)
      m2_it = FactoryGirl.create(:transaction, 
        invoice: m2_inv, updated_at: "3/3/2003", result: "success")

      get :date, params: { date: "3/3/2003" }
      
      result = response.body
      expect(result).to eq("125.00")
    end
  end
end
      