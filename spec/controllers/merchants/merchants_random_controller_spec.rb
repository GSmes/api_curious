require 'rails_helper'

RSpec.describe Api::V1::Merchants::RandomController do
  describe "GET random" do
    it "retrieves a random @merchant" do
      200.times do
        FactoryGirl.create(:merchant)
      end

      get :show
      first_random_merchant = assigns(:merchant)

      get :show
      second_random_merchant = assigns(:merchant)

      expect(first_random_merchant).to_not eq(second_random_merchant)
      expect(response.status).to eq(200)

      parsed_merchant = JSON.parse(response.body)

      expect(parsed_merchant.class).to eq(Hash)
      expect(parsed_merchant.keys).to include("name")
    end
  end
end
