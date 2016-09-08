class Api::V1::Customers::TransactionsController < ApplicationController
  respond_to :json
  
  def index
    invoices = Invoice.where(customer_id: params[:id])
    @transactions = []
    invoices.each do |invoice|
      @transactions << Transaction.where(invoice_id: invoice.id)
    end
    @transactions = @transactions.flatten
  end
end