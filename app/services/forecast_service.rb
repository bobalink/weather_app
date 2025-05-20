class ForecastService
  def get_forecast(query)

    uri = URI('http://api.weatherstack.com/current')
    params = { :access_key => Rails.application.credentials.weatherstack.api_key , query: query, units: 'f' }
    uri.query = URI.encode_www_form(params)

    res = Net::HTTP.get_response(uri)
    response_body_obj = JSON.parse(res.body)

    # We have to do a check for response_body_obj['success'] != false because the weatherstack API returns a 200
    # but also includes a success value that needs to be considered
    if res.is_a?(Net::HTTPSuccess) && response_body_obj['success'] != false
      Forecast.new(JSON.parse(res.body))
    else
      raise Exception.new("Error in retrieving forecast data")
    end
  end
end