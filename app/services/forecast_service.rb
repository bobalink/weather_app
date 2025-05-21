class ForecastService
  def get_forecast(query)

    uri = URI('http://api.weatherstack.com/current')
    params = { :access_key => Rails.application.credentials.weatherstack.api_key , query: query, units: 'f' }
    uri.query = URI.encode_www_form(params)

    res = Net::HTTP.get_response(uri)
    weatherstack_response_hash = JSON.parse(res.body)

    # We have to do a check for response_body_obj['success'] != false because the weatherstack API returns a 200
    # but also includes a success value that needs to be considered
    if res.is_a?(Net::HTTPSuccess) && weatherstack_response_hash['success'] != false
      Forecast.new(reformat_response_data(weatherstack_response_hash))
    else
      raise Exception.new("Error in retrieving forecast data")
    end
  end


  def reformat_response_data(weatherstack_response_hash)
    current_weather = weatherstack_response_hash['current']
    {
      current_temperature: current_weather['temperature'],
      weather_description: current_weather['weather_descriptions']&.first,
      # for whatever reason the weatherstack API returns feelslike rather than feels_like
      feels_like: current_weather['feelslike'],
      weather_icons: current_weather["weather_icons"],
      location_name: weatherstack_response_hash.dig("location","name"),
      region: weatherstack_response_hash.dig("location","region"),
      wind_speed: current_weather['wind_speed'],
      wind_dir: current_weather['wind_dir']
    }
  end
end