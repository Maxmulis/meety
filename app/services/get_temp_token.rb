

class GetTempToken < ApplicationService

  def call
    mapbox_token = Rails.application.credentials.mapbox
    expires = (DateTime.now + 10.minutes).strftime("%FT%T%:z")
    options = {
      headers: {
        "Content-Type": "application/json"
      },
      body:
        {
          expires: expires,
          scopes: ["styles:read", "fonts:read", "styles:tiles"]
        }.to_json
             }
    url = "https://api.mapbox.com/tokens/v2/maxmulis?access_token=#{mapbox_token}"
    response = HTTParty.post(url, options)
    response["token"]
  end

end
