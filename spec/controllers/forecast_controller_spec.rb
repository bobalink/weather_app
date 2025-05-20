# frozen_string_literal: true
require 'rails_helper'

describe ForecastController, type: :controller do
  let(:weather_service_mock) { instance_double(ForecastService) }

  let(:mocked_forcast_object) {
    Forecast.new(
      {
        current: {
          temperature: '72',
          weather_descriptions: ['Nice and Sunny']
        }
      }.with_indifferent_access
    )
  }

  describe "Forcast Controller" do

    # Allows Rails.cache to behave just like it would on dev and prod!
    let(:memory_store) { ActiveSupport::Cache.lookup_store(:memory_store) }

    before do
      allow(Rails).to receive(:cache).and_return(memory_store)
      Rails.cache.clear
      allow(ForecastService).to receive(:new).and_return weather_service_mock
      allow(weather_service_mock).to receive(:get_forecast).and_return mocked_forcast_object
    end

    it "should call the forecast service" do
      get :index
      expect(response).to have_http_status(:ok)
    end

    it 'should use the params passed in for the forecast service' do
      get :index, params: { query: '80211' }
      expect(weather_service_mock).to have_received(:get_forecast).with('80211')
    end

    it 'should set the response from the forecast service to the @forecast variable' do
        get :index, params: { query: '80211' }
        expect(assigns(:weather)).to eq mocked_forcast_object
    end

    it 'should return the cached value if it exists' do
      get :index, params: { query: '80211' }
      expect(assigns(:zip_cache_exist)).to eq false

      get :index, params: { query: '80211' }
      expect(assigns(:zip_cache_exist)).to eq true
    end
  end
end