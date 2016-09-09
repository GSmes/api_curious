class Api::V1::Customers::RandomController < ApplicationController

  def show
    @customer = Customer.random
    respond_with @customer
  end
end
