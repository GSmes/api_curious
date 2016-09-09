class Api::V1::Merchants::RandomController < ApplicationController

  def show
    @merchant = Merchant.random
    respond_with @merchant
  end
end
