

class GetTempToken < ApplicationService

  def call
    mapbox_token = Rails.application.credentials.mapbox
    expires = (DateTime.now + 10.minutes).strftime("%FT%R")
    options = {
      body:
        {
          expires: expires,
          scopes: ["styles:read", "fonts:read", "styles:tiles"]
        }
    }
    url = "https://api.mapbox.com/tokens/v2/maxmulis?access_token=#{mapbox_token}"
    response = HTTParty.post(url, options)
    response["token"]
  end

end
