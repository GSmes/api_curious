class Api::V1::Customers::RandomController < ApiBaseController
  respond_to :json

  def show
    respond_with Customer.order("RANDOM()").first
  end
end
