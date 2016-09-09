require 'rails_helper'

RSpec.describe Api::V1::Merchants::MostItemsController do
  describe "GET most items" do
    it "retrieves the merchants ranked by number of items sold" do
      merchant_1, merchant_2, merchant_3 = FactoryGirl.create_list(:merchant, 3)

      invoice_1 = FactoryGirl.create(:invoice, merchant: merchant_1)
      invoice_2 = FactoryGirl.create(:invoice, merchant: merchant_2)
      invoice_3 = FactoryGirl.create(:invoice, merchant: merchant_3)

      FactoryGirl.create(:transaction, invoice: invoice_1, result: "success")
      FactoryGirl.create(:transaction, invoice: invoice_2, result: "success")
      FactoryGirl.create(:transaction, invoice: invoice_3, result: "success")

      item_1 = FactoryGirl.create(:item, merchant: merchant_1)
      item_2 = FactoryGirl.create(:item, merchant: merchant_1)
      item_3 = FactoryGirl.create(:item, merchant: merchant_2)
      item_4 = FactoryGirl.create(:item, merchant: merchant_3)

      FactoryGirl.create(
        :invoice_item,
        invoice: invoice_1,
        item: item_1,
        quantity: 2
      )
      FactoryGirl.create(
        :invoice_item,
        invoice: invoice_1,
        item: item_2,
        quantity: 4
      )
      FactoryGirl.create(
        :invoice_item,
        invoice: invoice_2,
        item: item_3,
        quantity: 1
      )
      FactoryGirl.create(
        :invoice_item,
        invoice: invoice_3,
        item: item_4,
        quantity: 8
      )

      get :index, params: { quantity: 2 }

      expect(response.status).to eq(200)

      parsed_response = JSON.parse(response.body)

      expect(parsed_response.class).to eq(Array)
      expect(parsed_response.count).to eq(2)
      expect(parsed_response.first["id"]).to eq(merchant_3.id)
      expect(parsed_response.last["id"]).to eq(merchant_1.id)
    end
  end
end
