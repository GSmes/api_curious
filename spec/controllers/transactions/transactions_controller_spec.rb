require "rails_helper"

RSpec.describe Api::V1::TransactionsController do
  describe "GET index" do
    it "assigns all transactions to @transactions" do
      9.times do
        FactoryGirl.create(:transaction)
      end

      get :index

      expect(response.status).to eq(200)
      expect(assigns(:transactions).count).to eq(9)

      transactions = JSON.parse(response.body)

      expect(transactions.count).to eq(9)
    end
  end

  describe "GET show" do
    it "retrieves the correct @transaction" do
      FactoryGirl.create(
        :transaction,
        id: 1,
        credit_card_number: "4242424242424242",
        result: "success"
      )
      FactoryGirl.create(
        :transaction,
        id: 2,
        credit_card_number: "0101010101010101",
        result: "failed"
      )

      get :show, params: { id: 1 }

      expect(response.status).to eq(200)
      expect(assigns(:transaction).credit_card_number).to eq("4242424242424242")
      expect(assigns(:transaction).credit_card_number).to_not eq("0101010101010101")
      expect(assigns(:transaction).result).to eq("success")
      expect(assigns(:transaction).result).to_not eq("failed")
    end
  end
end
