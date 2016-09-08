class Api::V1::Invoices::InvoiceItemsController < ApplicationController
  respond_to :json

  def index
    @invoice_items = Invoice.find(params[:id]).invoice_items
    respond_with @invoice_items
  end
end
