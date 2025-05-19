class WeatherService
  def get_forecast(query)

    uri = URI('http://api.weatherstack.com/current')
    params = { :access_key => Rails.application.credentials.weatherstack.api_key , query: query, units: 'f' }
    uri.query = URI.encode_www_form(params)

    res = Net::HTTP.get_response(uri)

    puts "response body"
    puts res.body if res.is_a?(Net::HTTPSuccess)
    puts "\n"

    forecast = Forecast.new(JSON.parse(res.body))

    puts "forcast obj"
    puts forecast.instance_values


    return Forecast.new(JSON.parse(res.body))
  end
end