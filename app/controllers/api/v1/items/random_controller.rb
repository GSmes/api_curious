class Api::V1::Items::RandomController < ApplicationController
  respond_to :json
  
  def show
    @item = Item.order("RANDOM()").first
    respond_with @item
  end
end