class Api::V1::CustomersController < ApplicationController

  def index
    @customers = Customer.all
    respond_with @customers
  end

  def show
    @customer = Customer.find(params[:id])
    respond_with @customer
  end
end
