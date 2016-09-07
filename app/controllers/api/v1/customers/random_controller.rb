class Api::V1::Customers::RandomController < ApplicationController
  respond_to :json

  def show
    @customer = Customer.random
    respond_with @customer
  end
end
