require "rails_helper"

RSpec.describe Api::V1::CustomersController do
  describe "GET index" do
    it "assigns all customers to @customers" do
      10.times do
        FactoryGirl.create(:customer)
      end

      get :index

      expect(response.status).to eq(200)
      expect(assigns(:customers).count).to eq(10)

      customers = JSON.parse(response.body)

      expect(customers.count).to eq(10)
    end
  end

  describe "GET show" do
    it "retrieves the correct @customer" do
      FactoryGirl.create(:customer, id: 1, first_name: "Bill", last_name: "Burr")
      FactoryGirl.create(:customer, id: 2, first_name: "Jerry", last_name: "Seinfeld")

      get :show, params: { id: 1 }

      expect(response.status).to eq(200)
      expect(assigns(:customer).first_name).to eq("Bill")
      expect(assigns(:customer).first_name).to_not eq("Jerry")
      expect(assigns(:customer).last_name).to eq("Burr")
      expect(assigns(:customer).last_name).to_not eq("Seinfeld")
    end
  end
end
