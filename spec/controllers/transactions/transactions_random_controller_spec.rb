require 'rails_helper'

RSpec.describe Api::V1::Transactions::RandomController do
  describe "GET random" do
    it "retrieves a random @transaction" do
      200.times do
        FactoryGirl.create(:transaction)
      end

      get :show
      first_random_transaction = assigns(:transaction)

      get :show
      second_random_transaction = assigns(:transaction)

      expect(first_random_transaction).to_not eq(second_random_transaction)
      expect(response.status).to eq(200)

      parsed_transaction = JSON.parse(response.body)

      expect(parsed_transaction.class).to eq(Hash)
      expect(parsed_transaction.keys).to include("credit_card_number", "result")
    end
  end
end
