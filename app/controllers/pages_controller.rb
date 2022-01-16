require 'net/http'

class PagesController < ApplicationController
  rescue_from Net::HTTPBadRequest, with: :bad_request

  def index
    # json = GetPage.call("")
    # render json: json, status: :ok
  end

  private

  def bad_request(error)
    render json: error.body, status: :bad_request
  end
end
