class Api::V1::Invoices::ItemsController < ApplicationController

  def index
    @items = Invoice.find(params[:id]).items
    respond_with @items
  end
end
