# frozen_string_literal: true
require 'rails_helper'

describe ForecastService do

  let(:current_class) { ForecastService.new }

  let(:input_query) { '80211' }
  describe "get_forecast" do

    it 'calls the weatherstack api with the weatherstack api credentials, the query and units' do
      stub_request(:get, 'http://api.weatherstack.com/current')
        .with(query: { access_key: Rails.application.credentials.weatherstack.api_key, query: input_query, units: 'f'})
        .to_return(status: 200, body: {
          current: {
            temperature: '72',
            weather_descriptions: ['Nice and Sunny']
          }
        }.to_json)

      #this test would fail if the stub wasn't correct
      current_class.get_forecast(input_query)
    end

    context 'failed called to weatherstack' do
      it 'Raises an error' do

        stub_request(:get, 'http://api.weatherstack.com/current')
          .with(query: { access_key: Rails.application.credentials.weatherstack.api_key, query: input_query, units: 'f'})
          .to_return(status: 400, body: {
            current: {
              temperature: '72',
              weather_descriptions: ['Nice and Sunny']
            }
          }.to_json)
        expect { current_class.get_forecast(input_query) }.to raise_error(Exception)
      end
    end
  end
end