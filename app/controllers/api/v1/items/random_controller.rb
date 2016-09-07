class Api::V1::Items::RandomController < ApplicationController
  def show
    @item = Item.order("RANDOM()").first
    respond_with @item
  end
end