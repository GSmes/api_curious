class Api::V1::Invoices::CustomersController < ApplicationController
  respond_to :json

  def show
    @customer = Invoice.find(params[:id]).customer
    respond_with @customer
  end
end
