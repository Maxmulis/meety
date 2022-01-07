class PagesController < ApplicationController
  def index
    @r = request.ip
  end
end
