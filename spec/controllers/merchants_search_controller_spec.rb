require 'rails_helper'

RSpec.describe Api::V1::Merchants::SearchController do
  describe "GET find_all?params" do
    it "retrieves all merchants correctly" do
      10.times do
        FactoryGirl.create(:merchant, name: "Melissa McCarthy")
      end

      get :index, params: { name: "Melissa McCarthy" }

      expect(response.status).to eq(200)
      expect(assigns(:merchants).count).to eq(10)

      parsed_merchants = JSON.parse(response.body)

      expect(parsed_merchants.count).to eq(10)
    end

    it "retrieves only all matching merchants correctly" do
      2.times do
        FactoryGirl.create(:merchant, name: "Melissa McCarthy")
      end

      7.times do
        FactoryGirl.create(:merchant, name: "Eddie Murphy")
      end

      get :index, params: { name: "Eddie Murphy" }

      expect(response.status).to eq(200)
      expect(assigns(:merchants).count).to eq(7)
    end
  end

  describe "GET find?params" do
    it "finds first search result correctly" do
      5.times do |n|
        FactoryGirl.create(:merchant, id: "#{n+1}", name: "Martin Short")
      end

      get :show, params: { name: "Martin Short" }

      expect(response.status).to eq(200)
      expect(assigns(:merchant).class).to eq(Merchant)
      expect(assigns(:merchant).id).to eq(1)
      expect(assigns(:merchant).name).to eq("Martin Short")
    end
  end
end
