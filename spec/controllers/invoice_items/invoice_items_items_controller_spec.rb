require 'rails_helper'

RSpec.describe Api::V1::InvoiceItems::ItemsController do
  describe "GET associated item" do
    it "retrieves the correct item for that invoice_item" do
      item = FactoryGirl.create(:item, id: 1)
      10.times do
        FactoryGirl.create(:item)
      end

      FactoryGirl.create(
        :invoice_item,
        id: 1,
        item: item
      )

      get :show, params: { id: 1 }

      expect(response.status).to eq(200)
      expect(assigns(:item).id).to eq(1)
    end

    it "does not retrieve an item unrelated to that invoice_item" do
      3.times do |n|
        FactoryGirl.create(:item, id: "#{n+1}")
      end

      FactoryGirl.create(
        :invoice_item,
        id: 1,
        item: FactoryGirl.create(:item)
      )

      get :show, params: { id: 1 }

      expect(assigns(:item)).to_not be_within(1).of(2)
    end
  end
end
