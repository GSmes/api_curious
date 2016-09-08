require 'rails_helper'

RSpec.describe Api::V1::Invoices::SearchController do
  describe "GET find_all?params" do
    it "retrieves all possible search results correctly" do
      10.times do
        FactoryGirl.create(:invoice)
      end
        
      get :index, params: {
        invoice: { status: "Rockin' and Rollin'" }
      }
      expect(assigns(:invoices).count).to eq(10)
    end
    
    it "retrieves a subset of search results correctly" do
      5.times do
        FactoryGirl.create(:invoice)
        FactoryGirl.create(:invoice, status: "Subset")
      end
      
      get :index, params: {
        invoice: { status: "Subset" }
      }
      expect(assigns(:invoices).count).to eq(5)
    end
  end
  
  describe "GET find?params" do
    it "finds first search result correctly" do
      5.times do
        FactoryGirl.create(:invoice)
      end
      
      get :show, params: {
        invoice: { status: "Rockin' and Rollin'" }
      }
      expect(assigns(:invoice)).to be_a(Invoice)
    end
  end
end