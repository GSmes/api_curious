require 'rails_helper'

RSpec.describe Api::V1::Merchants::ItemsController do
  describe "GET related items for that merchant" do
    it "retrieves items related to that merchant" do
      merchant = FactoryGirl.create(:merchant, id: 1)
      5.times do
        FactoryGirl.create(:item, merchant: merchant)
      end
      get :index, params: {
        format: :json,
        id: 1
      }
      expect(assigns(:items).count).to eq(5)
    end
    
    it "does not retrieve items unrelated to that merchant" do
      FactoryGirl.create(:merchant, id: 1)
      5.times do
        FactoryGirl.create(:item)
      end
      get :index, params: {
        format: :json,
        id: 1
      }
      expect(assigns(:items).count).to eq(0)
    end
  end
end