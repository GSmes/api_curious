class Api::V1::Invoices::CustomersController < ApplicationController

  def show
    @customer = Invoice.find(params[:id]).customer
    respond_with @customer
  end
end
