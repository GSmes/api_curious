class Api::V1::Invoices::MerchantsController < ApplicationController

  def show
    @merchant = Invoice.find(params[:id]).merchant
    respond_with @merchant
  end
end
