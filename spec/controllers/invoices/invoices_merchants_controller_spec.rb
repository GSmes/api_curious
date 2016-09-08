require 'rails_helper'

RSpec.describe Api::V1::Invoices::MerchantsController do
  describe "GET associated merchant" do
    it "retrieves the correct merchant for that invoice" do
      10.times do
        FactoryGirl.create(:merchant)
      end

      FactoryGirl.create(
        :invoice,
        id: 1,
        merchant: FactoryGirl.create(:merchant, id: 20)
      )

      get :show, params: { id: 1 }

      expect(response.status).to eq(200)
      expect(assigns(:merchant).id).to eq(20)
    end

    it "does not retrieve a merchant unrelated to that invoice" do
      3.times do |n|
        FactoryGirl.create(:merchant, id: "#{n+1}")
      end

      FactoryGirl.create(
        :invoice,
        id: 1,
        merchant: FactoryGirl.create(:merchant)
      )

      get :show, params: { id: 1 }

      expect(assigns(:merchant)).to_not be_within(1).of(2)
    end
  end
end
