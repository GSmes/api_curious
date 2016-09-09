class Api::V1::Items::RandomController < ApplicationController
  respond_to :json
  
  def show
    @item = Item.random
    respond_with @item
  end
end
