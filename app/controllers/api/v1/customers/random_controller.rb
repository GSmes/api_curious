class Api::V1::Customers::RandomController < ApiBaseController
  respond_to :json

  def show
    @customer = Customer.order("RANDOM()").first
    respond_with @customer
  end
end
