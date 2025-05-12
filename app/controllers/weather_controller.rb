require 'net/http'

class WeatherController < ApplicationController
  def index
    puts params

    query = params[:query]


    puts 'query is'
    puts query


    uri = URI('http://api.weatherstack.com/current')
    params = { :access_key => Rails.application.credentials.weatherstack.api_key , query: query, units: 'f' }
    uri.query = URI.encode_www_form(params)

    res = Net::HTTP.get_response(uri)

    puts res.body if res.is_a?(Net::HTTPSuccess)
    @data = JSON.parse(res.body)
  end
end
