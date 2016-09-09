require 'rails_helper'

RSpec.describe Api::V1::Merchants::MostItemsController do
  describe "GET most items" do
    xit "retrieves the merchants ranked by number of items sold" do
      # need to figure out how to write this test. Currently returning empty array
      merchant_1 = FactoryGirl.create(:merchant, id: 1)
      merchant_2 = FactoryGirl.create(:merchant, id: 2)
      merchant_3 = FactoryGirl.create(:merchant, id: 3)

      invoice_1 = FactoryGirl.create(:invoice, merchant: merchant_1)
      invoice_2 = FactoryGirl.create(:invoice, merchant: merchant_2)
      invoice_3 = FactoryGirl.create(:invoice, merchant: merchant_3)

      item_1 = FactoryGirl.create(:item, merchant: merchant_1)
      item_2 = FactoryGirl.create(:item, merchant: merchant_2)
      item_3 = FactoryGirl.create(:item, merchant: merchant_3)

      invoice_item_1 = FactoryGirl.create(
        :invoice_item,
        invoice: invoice_1,
        item: item_1,
        quantity: 3
      )
      invoice_item_2 = FactoryGirl.create(
        :invoice_item,
        invoice: invoice_1,
        item: item_1,
        quantity: 4
      )
      invoice_item_3 = FactoryGirl.create(
        :invoice_item,
        invoice: invoice_2,
        item: item_2,
        quantity: 1
      )
      invoice_item_4 = FactoryGirl.create(
        :invoice_item,
        invoice: invoice_3,
        item: item_3,
        quantity: 8
      )

      get :index, params: { quantity: 2 }

      expect(response.status).to eq(200)

      parsed_response = JSON.parse(response.body)

      expect(parsed_response.class).to eq(Array)
      binding.pry
      expect(parsed_response.count).to eq(2)
      expect(parsed_response.first["id"]).to eq(merchant_1.id)
    end
  end
end
