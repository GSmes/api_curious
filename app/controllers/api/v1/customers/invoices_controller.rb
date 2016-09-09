class Api::V1::Customers::InvoicesController < ApplicationController
  respond_to :json
  
  def index
    @invoices = Invoice.where(customer_id: params[:id])
    respond_with @invoices
  end
end