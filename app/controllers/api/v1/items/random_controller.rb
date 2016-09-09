class Api::V1::Items::RandomController < ApplicationController

  def show
    @item = Item.random
    respond_with @item
  end
end
