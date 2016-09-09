class Api::V1::MerchantsController < ApplicationController
  respond_to :json

  def index
    @merchants = Merchant.all
    respond_with @merchants
  end

  def show
    @merchant = Merchant.find(params[:id])
    respond_with @merchant
  end
end
