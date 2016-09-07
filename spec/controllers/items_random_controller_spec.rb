require 'rails_helper'

RSpec.describe Api::V1::Items::RandomController do
  describe "GET random" do
    it "retrieves a random @item" do
      500.times do |n|
        FactoryGirl.create(:item)
      end
      get :show, params: { format: :json }
      first_random_item = assigns(:item)
      
      get :show, params: { format: :json }
      second_random_item = assigns(:item)
      
      expect(first_random_item).to_not eq(second_random_item)
    end
  end
end