require 'rails_helper'

RSpec.describe Api::V1::Invoices::RandomController do
  describe "GET random" do
    it "retrieves a random @invoice" do
      500.times do
        FactoryGirl.create(:invoice)
      end
      get :show
      first_random_invoice = assigns(:invoice)
      
      get :show
      second_random_invoice = assigns(:invoice)
      
      expect(first_random_invoice).to_not eq(second_random_invoice)
    end
  end
end