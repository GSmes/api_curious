class Api::V1::Invoices::RandomController < ApplicationController

  def show
    @invoice = Invoice.random
    respond_with @invoice
  end
end
