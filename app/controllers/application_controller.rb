require 'net/http'
class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  def index
    uri = URI('http://api.weatherstack.com/current')
    params = { :access_key => Rails.application.credentials.weatherstack.api_key , query: "80211" }
    uri.query = URI.encode_www_form(params)

    res = Net::HTTP.get_response(uri)
    puts res.body if res.is_a?(Net::HTTPSuccess)


    @data = JSON.parse(res.body)
  end



end
