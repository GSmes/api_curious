class Api::V1::Merchants::RevenueController < ApplicationController

  def index
    @merchants = Merchant.order_by_revenue(params[:quantity])
    respond_with @merchants
  end

  def show
    merchant = Merchant.find(params[:id])
    if params[:date]
      @revenue = merchant.revenue_on(params[:date])
      respond_with @revenue, serializer: RevenueSerializer
    else
      @revenue = merchant.total_revenue
      respond_with @revenue, serializer: RevenueSerializer
    end
  end

  def date
    @revenue = Merchant.total_revenue_on(params[:date])
    respond_with @revenue, serializer: TotalRevenueSerializer
  end
end
