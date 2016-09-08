class Api::V1::Merchants::RevenueController < ApplicationController
  respond_to :json
  
  def index
    @merchants = Merchant.order_by_revenue
    respond_with @merchants[0..(params[:quantity].to_i-1)]
  end
  
  def show
    merchant = Merchant.find(params[:id])
    @revenue = merchant.total_revenue
    respond_with @revenue
  end
end