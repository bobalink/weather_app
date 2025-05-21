class Forecast
  CACHE_EXPIRATION = 30.minutes

  attr_accessor :current_temperature,
                :from_cache,
                :feels_like,
                :location_name,
                :region,
                :weather_description,
                :weather_icons,
                :wind_dir,
                :wind_speed

  def initialize(attributes)
    attributes.each do |k, v|
      instance_variable_set("@#{k}", v) unless v.nil?
    end
  end
end
