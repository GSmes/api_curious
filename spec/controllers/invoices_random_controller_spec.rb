require 'rails_helper'

RSpec.describe Api::V1::Invoices::RandomController do
  describe "GET random" do
    it "retrieves a random @invoice" do
      200.times do |n|
        FactoryGirl.create(:invoice, id: n)
      end
      get :show, params: { format: :json }
      first_random_invoice = assigns(:invoice)
      
      get :show, params: { format: :json }
      second_random_invoice = assigns(:invoice)
      
      expect(first_random_invoice).to_not eq(second_random_invoice)
    end
  end
end