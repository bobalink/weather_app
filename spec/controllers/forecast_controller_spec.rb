# frozen_string_literal: true
require 'rails_helper'

describe ForecastController, type: :controller do
  let(:weather_service_mock) { instance_double(WeatherService) }



  let(:mocked_forcast_object) {
    Forecast.new(
      {
        current: {
          current_temperature: '72',
          weather_description: 'Nice and Sunny'
        }
      }.with_indifferent_access
    )
  }

  describe "Forcast Controller" do

    before do
      allow(WeatherService).to receive(:new).and_return weather_service_mock
      allow(weather_service_mock).to receive(:get_forecast).and_return mocked_forcast_object
    end

    # it "should call the weather service" do
    #   get :index
    #   expect(response).to have_http_status(:ok)
    # end
    #
    # it 'should use the params passed in for the weather service' do
    #   get :index, params: { query: '80211' }
    #   expect(weather_service_mock).to have_received(:get_forecast).with('80211')
    # end

    it 'should set the response from the weather service to the @weather variable' do
        get :index, params: { query: '80211' }
        expect(@weather).to eq mocked_forcast_object
    end
    #
    # it 'should return the cached value if it exists' do
    #
    # end

  end
end