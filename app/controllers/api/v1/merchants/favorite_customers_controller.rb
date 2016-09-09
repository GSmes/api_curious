class Api::V1::Merchants::FavoriteCustomersController < ApplicationController

  def show
    merchant = Merchant.find(params[:id])
    @customer = merchant.favorite_customer
    respond_with @customer
  end
end
