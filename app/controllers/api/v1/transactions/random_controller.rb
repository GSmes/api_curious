class Api::V1::Transactions::RandomController < ApplicationController
  respond_to :json

  def show
    @transaction = Transaction.order("RANDOM()").first
    respond_with @transaction
  end
end
