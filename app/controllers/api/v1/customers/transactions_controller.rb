class Api::V1::Customers::TransactionsController < ApplicationController
  respond_to :json

  def index
    @transactions = Customer.find(params[:id]).transactions
    respond_with @transactions
  end
end
