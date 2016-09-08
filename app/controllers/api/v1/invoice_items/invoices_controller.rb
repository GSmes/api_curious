class Api::V1::InvoiceItems::InvoicesController < ApplicationController
  respond_to :json

  def show
    @invoice = InvoiceItem.find(params[:id]).invoice
    respond_with @invoice
  end
end
