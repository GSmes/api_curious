require 'rails_helper'

RSpec.describe Api::V1::Items::SearchController do
  describe "GET find_all?params" do
    it "retrieves all possible search results correctly" do
      100.times do
        FactoryGirl.create(:item, unit_price: 9.99)
      end
      
      get :index, params: {
        format: :json,
        item: { unit_price: 9.99 }
      }
      expect(assigns(:items).count).to eq(100)
    end
    
    it "retrieves a subset of search results correctly" do
      50.times do
        FactoryGirl.create(:item, unit_price: 5.99)
        FactoryGirl.create(:item, unit_price: 9.99)
      end
      
      get :index, params: {
        format: :json,
        item: { unit_price: 5.99 }
      }
      expect(assigns(:items).count).to eq(50)
    end
  end
  
  describe "GET find?params" do
    it "finds first search result correctly" do
      50.times do
        FactoryGirl.create(:item, unit_price: 1.99)
      end
      
      get :show, params: {
        format: :json,
        item: { unit_price: 1.99 }
      }
      expect(assigns(:item)).to be_a(Item)
    end
  end
end