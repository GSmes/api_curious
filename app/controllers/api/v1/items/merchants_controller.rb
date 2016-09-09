class Api::V1::Items::MerchantsController < ApplicationController

  def show
    @merchant = Item.find(params[:id]).merchant
    respond_with @merchant
  end
end
