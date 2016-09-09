class Api::V1::InvoiceItems::ItemsController < ApplicationController

  def show
    @item = InvoiceItem.find(params[:id]).item
    respond_with @item
  end
end
