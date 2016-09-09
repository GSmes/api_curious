require 'rails_helper'

RSpec.describe Api::V1::Items::MostItemsController do
  describe "GET most items" do
    it "retrieves the most sold items ranked by number sold" do
      item_1, item_2, item_3 = FactoryGirl.create_list(:item, 3)

      invoice_item_1 = FactoryGirl.create(
        :invoice_item,
        item: item_1,
        quantity: 4
      )
      invoice_item_2 = FactoryGirl.create(
        :invoice_item,
        item: item_2,
        quantity: 3
      )
      invoice_item_3 = FactoryGirl.create(
        :invoice_item,
        item: item_3,
        quantity: 9
      )
      invoice_item_4 = FactoryGirl.create(
        :invoice_item,
        item: item_1,
        quantity: 2
      )

      get :index, params: { quantity: 2 }

      expect(response.status).to eq(200)

      parsed_response = JSON.parse(response.body)

      expect(parsed_response.class).to eq(Array)
      expect(parsed_response.count).to eq(2)
      expect(parsed_response.first["id"]).to eq(item_3.id)
      expect(parsed_response.last["id"]).to eq(item_1.id)
    end
  end
end
