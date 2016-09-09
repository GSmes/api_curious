class Api::V1::Customers::FavoriteMerchantController < ApplicationController
  respond_to :json

  def show
    @favorite_merchant = Customer.find(params[:id]).favorite_merchant
    respond_with @favorite_merchant
  end
end
