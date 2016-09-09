class Api::V1::Transactions::SearchController < ApplicationController

  def index
    @transactions = Transaction.where(transaction_params)
    respond_with @transactions
  end

  def show
    @transaction = Transaction.find_by(transaction_params)
    respond_with @transaction
  end

  private

  def transaction_params
    params.permit(
      :id,
      :invoice_id,
      :credit_card_number,
      :credit_card_expiration_date,
      :result,
      :created_at,
      :updated_at
    )
  end
end
