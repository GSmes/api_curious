class Api::V1::Invoices::SearchController < ApplicationController
  respond_to :json
  
  def index
    @invoices = Invoice.where(invoice_params)
    respond_with @invoices
  end
  
  def show
    @invoice = Invoice.find_by(invoice_params)
    respond_with @invoice
  end
  
  private
  
  def invoice_params
    params.require(:invoice).permit(
      :id,
      :customer_id,
      :merchant_id,
      :status,
      :created_at,
      :updated_at
    )
  end
end