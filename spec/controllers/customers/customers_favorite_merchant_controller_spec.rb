require 'rails_helper'

RSpec.describe Api::V1::Customers::FavoriteMerchantController do
  describe "GET favorite merchant" do
    it "retrieves favorite merchant for that customer" do
      customer = FactoryGirl.create(:customer)

      merchant_1, merchant_2 = create_list(:merchant, 2)

      3.times do |i|
        if i < 2
          invoice = FactoryGirl.create(:invoice,
                                       customer: customer,
                                       merchant: merchant_1)
          FactoryGirl.create(:transaction, invoice: invoice)
        else
          invoice = FactoryGirl.create(:invoice,
                                       customer: customer,
                                       merchant: merchant_2)
          FactoryGirl.create(:transaction, invoice: invoice)
        end
      end

      get :show, params: { id: customer.id }

      expect(response.status).to eq(200)

      parsed_favorite_merchant = JSON.parse(response.body)

      expect(parsed_favorite_merchant["id"]).to eq(merchant_1.id)
    end
  end
end
