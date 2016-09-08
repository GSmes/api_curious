require "rails_helper"

RSpec.describe Api::V1::MerchantsController do
  describe "GET index" do
    it "assigns all merchants to @merchants" do
      8.times do
        FactoryGirl.create(:merchant)
      end

      get :index

      expect(response.status).to eq(200)
      expect(assigns(:merchants).count).to eq(8)

      merchants = JSON.parse(response.body)

      expect(merchants.count).to eq(8)
    end
  end

  describe "GET show" do
    it "retrieves the correct @merchant" do
      FactoryGirl.create(:merchant, id: 1, name: "Bill Hader")
      FactoryGirl.create(:merchant, id: 2, name: "Andy Samberg")

      get :show, params: { id: 2 }

      expect(response.status).to eq(200)
      expect(assigns(:merchant).name).to eq("Andy Samberg")
      expect(assigns(:merchant).name).to_not eq("Bill Hader")
    end
  end
end
