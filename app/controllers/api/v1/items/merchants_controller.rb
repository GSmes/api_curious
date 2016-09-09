class Api::V1::Items::MerchantsController < ApplicationController
  respond_to :json

  def show
    @merchant = Item.find(params[:id]).merchant
    respond_with @merchant
  end
end
