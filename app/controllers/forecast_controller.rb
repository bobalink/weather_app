require "net/http"


class ForecastController < ApplicationController
  def index
    query = params[:query]

    if query
      verifier = MainStreet::AddressVerifier.new(query)
      # There are cases where you can provide just a city as an input and don't get a zip returned
      # With this in order to cache we need to validate there's a zip.
      unless verifier.success? && verifier.result.data["address"]["postcode"]
        raise Exception("Invalid address")
      end
      verified_zip = verifier.result.data["address"]["postcode"]
    end

    if verified_zip
      zip_cache_key = "#{verified_zip}"
      # Caching
      cache_exists = Rails.cache&.exist?(zip_cache_key)
      @weather = Rails.cache.fetch(zip_cache_key, expires_in: 30.minutes) do
        ForecastService.new.get_forecast(verified_zip)
      end
      @weather.from_cache = cache_exists
    end
  end
end
