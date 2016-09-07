class Api::V1::Items::SearchController < ApplicationController
  respond_to :json
  
  def index
    @item = Item.where(item_params)
    respond_with @item
  end
  
  def show
    @item = Item.find_by(item_params)
    respond_with @item
  end
  
  private 
  
  def item_params
    params.require(:item).permit(
      :id,
      :name,
      :description,
      :unit_price,
      :merchant_id,
      :created_at,
      :updated_at
    )
  end
end