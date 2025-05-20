require 'net/http'


class ForecastController < ApplicationController

  def index
    query = params[:query]

    #TODO: ensure query is only a zip code or expand it to capture zip code from the query

    # Caching
    @zip_cache_key = "#{query}" if query
    if @zip_cache_key
      @zip_cache_exist = Rails.cache.exist?(@zip_cache_key)
      @weather = Rails.cache.fetch(@zip_cache_key, expires_in: 30.minutes) do
        ForecastService.new.get_forecast(query)
      end
    end
  end
end
