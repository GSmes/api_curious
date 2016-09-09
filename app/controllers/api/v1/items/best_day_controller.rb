class Api::V1::Items::BestDayController < ApplicationController

  def show
    @best_day = Item.find(params[:id]).best_day
    respond_with @best_day, serializer: BestDaySerializer
  end
end
