require 'rails_helper'

RSpec.describe Api::V1::Customers::SearchController do
  describe "GET find_all?params" do
    it "retrieves all customers correctly" do
      10.times do
        FactoryGirl.create(:customer, first_name: "Mitch", last_name: "Hedberg")
      end

      get :index, params: { first_name: "Mitch" }

      expect(response.status).to eq(200)
      expect(assigns(:customers).count).to eq(10)

      parsed_customers = JSON.parse(response.body)

      expect(parsed_customers.count).to eq(10)
    end

    it "retrieves only all matching customers correctly" do
      2.times do
        FactoryGirl.create(:customer, first_name: "Mitch", last_name: "Hedberg")
      end

      7.times do
        FactoryGirl.create(:customer, first_name: "Kristen", last_name: "Wigg")
      end

      get :index, params: { first_name: "Kristen" }

      expect(response.status).to eq(200)
      expect(assigns(:customers).count).to eq(7)
    end
  end

  describe "GET find?params" do
    it "finds first search result correctly" do
      5.times do |n|
        FactoryGirl.create(:customer, id: "#{n+1}", first_name: "Chris", last_name: "Farley")
      end

      get :show, params: { first_name: "Chris" }

      expect(response.status).to eq(200)
      expect(assigns(:customer).class).to eq(Customer)
      expect(assigns(:customer).id).to eq(1)
      expect(assigns(:customer).first_name).to eq("Chris")
      expect(assigns(:customer).last_name).to eq("Farley")
    end
  end
end
