class Api::V1::Items::SearchController < ApplicationController

  def index
    @items = Item.where(item_params)
    respond_with @items
  end

  def show
    @item = Item.order(id: :asc).find_by(item_params)
    respond_with @item
  end

  private

  def item_params
    params.permit(
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
