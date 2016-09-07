require 'rails_helper'

RSpec.describe Api::V1::Invoices::SearchController do
  describe "GET find_all/params" do
    it "retrieves all possible search results correctly" do
      100.times do |n|
        FactoryGirl.create(:invoice)
      end
        
      get :index, params: {
        format: :json,
        invoice: { status: "Rockin' and Rollin'" }
      }
      expect(assigns(:invoices).count).to eq(100)
    end
    
    it "retrieves a subset of search results correctly" do
      50.times do |n|
        FactoryGirl.create(:invoice)
        FactoryGirl.create(:invoice, status: "Subset")
      end
      
      get :index, params: {
        format: :json,
        invoice: { status: "Subset" }
      }
      expect(assigns(:invoices).count).to eq(50)
    end
  end
  
  describe "GET find?params" do
    it "finds first search result correctly" do
      50.times do |n|
        FactoryGirl.create(:invoice)
      end
      
      get :show, params: {
        format: :json,
        invoice: { status: "Rockin' and Rollin'" }
      }
      expect(assigns(:invoice)).to be_a(Invoice)
    end
  end
end