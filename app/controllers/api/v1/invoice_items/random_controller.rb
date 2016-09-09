class Api::V1::InvoiceItems::RandomController < ApplicationController

  def show
    @invoice_item = InvoiceItem.random
    respond_with @invoice_item
  end
end
