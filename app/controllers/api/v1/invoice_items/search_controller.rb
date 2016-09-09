class Api::V1::InvoiceItems::SearchController < ApplicationController
  respond_to :json

  def index
    @invoice_items = InvoiceItem.where(invoice_item_params)
    respond_with @invoice_items
  end

  def show
    @invoice_item = InvoiceItem.find_by(invoice_item_params)
    respond_with @invoice_item
  end

  private

  def invoice_item_params
    params.permit(
      :id,
      :invoice_id,
      :item_id,
      :quantity,
      :unit_price,
      :created_at,
      :updated_at
    )
  end
end
