require 'net/http'


class ForecastController < ApplicationController

  def index
    query = params[:query]

    puts 'query is'
    puts query

    #TODO: ensure query is only a zip code or expand it to capture zip code from the query

    # Caching
    @zip_cache_key = "#{query}" if query

    if @zip_cache_key

      puts "@zip_cache_key"
      puts @zip_cache_key
      @zip_cache_exist = Rails.cache.exist?(@zip_cache_key)

      puts "@zip_cache_exist",  @zip_cache_exist

      @weather = Rails.cache.fetch(@zip_cache_key, expires_in: 30.minutes) do
        puts 'calling weather service'
        WeatherService.new.get_forecast(query)
      end
    end


    puts "weather.to_json "
    puts @weather.to_json


  end
end
