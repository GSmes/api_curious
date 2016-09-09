class Api::V1::Merchants::InvoicesController < ApplicationController

  def index
    @invoices = Invoice.where(merchant_id: params[:id])
    respond_with @invoices
  end
end
