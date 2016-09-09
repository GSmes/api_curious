class Api::V1::Transactions::InvoicesController < ApplicationController

  def show
    transaction = Transaction.find(params[:id])
    @invoice = Invoice.find(transaction.invoice_id)
    respond_with @invoice
  end
end
