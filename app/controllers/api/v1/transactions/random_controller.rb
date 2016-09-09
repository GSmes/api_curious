class Api::V1::Transactions::RandomController < ApplicationController

  def show
    @transaction = Transaction.random
    respond_with @transaction
  end
end
