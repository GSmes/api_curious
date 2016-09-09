class Api::V1::Merchants::ItemsController < ApplicationController

  def index
    @items = Item.where(merchant_id: params[:id])
    respond_with @items
  end
end
