require "rails_helper"

RSpec.describe Api::V1::ItemsController do
  describe "GET index" do
    it "assigns @items" do
      10.times do
        FactoryGirl.create(:item)
      end
      get :index, format: :json
      expect(assigns(:items).count).to eq(10)
    end
  end
  
  describe "GET show" do
    it "retrieves the correct @item" do
      FactoryGirl.create(:item, id: 1, name: "Kawai Piano")
      FactoryGirl.create(:item, id: 2, name: "Steinway Piano")
      
      get :show, params: { id: 1, format: :json }
      expect(assigns(:item).name).to eq("Kawai Piano")
      expect(assigns(:item).name).to_not eq("Steinway Piano")
    end
  end
end