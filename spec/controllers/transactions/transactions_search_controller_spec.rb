require 'rails_helper'

RSpec.describe Api::V1::Transactions::SearchController do
  describe "GET find_all?params" do
    it "retrieves all transactions correctly" do
      10.times do
        FactoryGirl.create(:transaction, credit_card_number: "0101010101010101")
      end

      get :index, params: { credit_card_number: "0101010101010101" }

      expect(response.status).to eq(200)
      expect(assigns(:transactions).count).to eq(10)

      parsed_transactions = JSON.parse(response.body)

      expect(parsed_transactions.count).to eq(10)
    end

    it "retrieves only all matching transactions correctly" do
      2.times do
        FactoryGirl.create(:transaction, credit_card_number: "0101010101010101")
      end

      7.times do
        FactoryGirl.create(:transaction, credit_card_number: "4242424242424242")
      end

      get :index, params: { credit_card_number: "4242424242424242" }

      expect(response.status).to eq(200)
      expect(assigns(:transactions).count).to eq(7)
    end
  end

  describe "GET find?params" do
    it "finds first search result correctly" do
      5.times do |n|
        FactoryGirl.create(:transaction, id: "#{n+1}", credit_card_number: "9797979797979797")
      end

      get :show, params: { credit_card_number: "9797979797979797" }

      expect(response.status).to eq(200)
      expect(assigns(:transaction).class).to eq(Transaction)
      expect(assigns(:transaction).id).to eq(1)
      expect(assigns(:transaction).credit_card_number).to eq("9797979797979797")
    end
  end
end
