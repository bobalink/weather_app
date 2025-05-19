class Forecast
  CACHE_EXPIRATION = 30.minutes

  attr_accessor :current_temperature,
                :from_cache,
                :feelslike,
                :location_name,
                :region,
                :weather_description,
                :weather_icons,
                :wind_dir,
                :wind_speed

  def initialize(attributes)

    puts 'attributes when initalizing'
    puts attributes
    puts "\n"

    current_weather = attributes['current']

    puts "current"
    puts current_weather

    @current_temperature = current_weather["temperature"]
    @weather_description = current_weather["weather_descriptions"]&.first
    @feelslike = current_weather["feelslike"]
    @weather_icons = current_weather["weather_icons"]
    @location_name = attributes["location"]["name"]
    @region = attributes["location"]["region"]
    @wind_speed = current_weather['wind_speed']
    @wind_dir = current_weather['wind_dir']
  end
end