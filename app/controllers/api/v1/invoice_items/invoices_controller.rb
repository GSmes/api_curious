class Api::V1::InvoiceItems::InvoicesController < ApplicationController

  def show
    @invoice = InvoiceItem.find(params[:id]).invoice
    respond_with @invoice
  end
end
