class Api::V1::Merchants::RandomController < ApplicationController
  respond_to :json

  def show
    @merchant = Merchant.random
    respond_with @merchant
  end
end
