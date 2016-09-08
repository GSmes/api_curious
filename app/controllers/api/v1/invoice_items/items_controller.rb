class Api::V1::InvoiceItems::ItemsController < ApplicationController
  respond_to :json

  def show
    @item = InvoiceItem.find(params[:id]).item
    respond_with @item
  end
end
