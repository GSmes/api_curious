require 'rails_helper'

RSpec.describe Api::V1::Customers::RandomController do
  describe "GET random" do
    it "retrieves a random @customer" do
      200.times do
        FactoryGirl.create(:customer)
      end

      get :show
      first_random_customer = assigns(:customer)

      get :show
      second_random_customer = assigns(:customer)

      expect(first_random_customer).to_not eq(second_random_customer)
      expect(response.status).to eq(200)

      parsed_customer = JSON.parse(response.body)

      expect(parsed_customer.class).to eq(Hash)
      expect(parsed_customer.keys).to include("first_name", "last_name")
    end
  end
end
