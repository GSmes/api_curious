class Api::V1::InvoicesController < ApplicationController
  respond_to :json
  
  def index
    @invoices = Invoice.all
  end
  
  def show
    @invoice = Invoice.find(params[:id])
  end
  
  def random
    @invoice = Invoice.all.shuffle.pop
  end
end