require 'rails_helper'

RSpec.describe Api::V1::Items::BestDayController do
  describe "GET best day" do
    it "retrieves the date with the most sales for that item" do
      item = FactoryGirl.create(:item)

      invoice_1 = FactoryGirl.create(:invoice, created_at: "2015-03-23T12:53:59.000Z")
      invoice_2 = FactoryGirl.create(:invoice, created_at: "2014-02-23T12:53:59.000Z")
      invoice_3 = FactoryGirl.create(:invoice, created_at: "2013-01-23T12:53:59.000Z")

      invoice_item_1 = FactoryGirl.create(:invoice_item, invoice: invoice_1, item: item, quantity: 1)
      invoice_item_2 = FactoryGirl.create(:invoice_item, invoice: invoice_2, item: item, quantity: 2)
      invoice_item_3 = FactoryGirl.create(:invoice_item, invoice: invoice_3, item: item, quantity: 4)

      get :show, params: { id: item.id }

      expect(response.status).to eq(200)

      parsed_best_day = JSON.parse(response.body)

      expect(parsed_best_day["best_day"]).to eq("2013-01-23T12:53:59.000Z")
    end
  end
end
