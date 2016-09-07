class Api::V1::Merchants::RandomController < ApiBaseController
  respond_to :json

  def show
    respond_with Merchant.order("RANDOM()").first
  end
end
