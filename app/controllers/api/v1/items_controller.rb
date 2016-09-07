class Api::V1::ItemsController < ApplicationController
  respond_to :json
  
  def index
    @items = Item.all
  end
  
  def show
    @item = Item.find(params[:id])
  end
  
  def random
    @item = Item.all.shuffle.pop
  end
end