class Api::V1::Invoices::MerchantsController < ApplicationController
  respond_to :json

  def show
    @merchant = Invoice.find(params[:id]).merchant
    respond_with @merchant
  end
end
