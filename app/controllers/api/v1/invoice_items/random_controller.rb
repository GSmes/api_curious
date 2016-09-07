class Api::V1::InvoiceItems::RandomController < ApplicationController
  respond_to :json
  
  def show
    @invoice_item = InvoiceItem.random
    respond_with @invoice_item
  end
end