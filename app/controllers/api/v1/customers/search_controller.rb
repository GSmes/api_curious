class Api::V1::Customers::SearchController < ApiBaseController
  respond_to :json

  def index
    @customers = Customer.where(customer_params)
    respond_with @customers
  end

  def show
    @customer = Customer.find_by(customer_params)
    respond_with @customer
  end

  private

  def customer_params
    params.permit(
      :id,
      :first_name,
      :last_name,
      :created_at,
      :updated_at
    )
  end
end
