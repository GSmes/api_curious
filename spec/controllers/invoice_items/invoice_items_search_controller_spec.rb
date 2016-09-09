require 'rails_helper'

RSpec.describe Api::V1::InvoiceItems::SearchController do
  describe "GET find_all?params" do
    it "retrieves all possible search results correctly" do
      10.times do
        FactoryGirl.create(:invoice_item, unit_price: 9.99)
      end

      get :index, params: { unit_price: 9.99 }

      expect(assigns(:invoice_items).count).to eq(10)
    end

    it "retrieves a subset of search results correctly" do
      5.times do
        FactoryGirl.create(:invoice_item, unit_price: 4.99)
        FactoryGirl.create(:invoice_item, unit_price: 100)
      end

      get :index, params: { unit_price: 100 }

      expect(assigns(:invoice_items).count).to eq(5)
    end
  end

  describe "GET find?params" do
    it "finds first search result correctly" do
      5.times do
        FactoryGirl.create(:invoice_item, unit_price: 50)
      end

      get :show, params: { unit_price: 50 }

      expect(assigns(:invoice_item)).to be_a(InvoiceItem)
    end
  end
end
