class Api::V1::Merchants::CustomersPendingInvoicesController < ApplicationController
  respond_to :json
  
  def index
    merchant = Merchant.find(params[:id])
    @customers = Customer.where(id: merchant.customers_with_pending_invoices)
    respond_with @customers
  end
end