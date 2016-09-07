require "application_responder"

class ApplicationController < ActionController::Base
  before_action :set_default_response_format

  self.responder = ApplicationResponder
  respond_to :html

  protect_from_forgery with: :exception

  private

  def set_default_response_format
    request.format = :json
  end
end
