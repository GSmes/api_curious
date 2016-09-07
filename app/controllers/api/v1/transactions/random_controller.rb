class Api::V1::Transactions::RandomController < ApiBaseController
  respond_to :json

  def show
    respond_with Transaction.order("RANDOM()").first
  end
end
