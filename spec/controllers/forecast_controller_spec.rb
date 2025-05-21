# frozen_string_literal: true
require 'rails_helper'

describe ForecastController, type: :controller do
  let(:weather_service_mock) { instance_double(ForecastService) }
  let(:mock_address_validator) { instance_double(MainStreet::AddressVerifier) }
  let(:mock_address_validation_result) {}
  let(:mock_address_validation_result_data) {
    {
      "address" => {
        "postcode" => "80211"
      }
    }
  }

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
      allow(MainStreet::AddressVerifier).to receive(:new).and_return mock_address_validator
    end

    describe 'valid address input' do
      before do
        allow(mock_address_validator).to receive(:success?).and_return true
        allow(mock_address_validator).to receive(:result).and_return mock_address_validation_result
        allow(mock_address_validation_result).to receive(:data).and_return mock_address_validation_result_data
      end
      it "should call the forecast service" do
        get :index
        expect(response).to have_http_status(:ok)
      end

      it 'should pass the validated address to weather service' do
        get :index, params: { query: '' }
        expect(weather_service_mock).to have_received(:get_forecast).with('80211')
      end

      it 'should set the response from the forecast service to the @forecast variable' do
        get :index, params: { query: '80211' }
        expect(assigns(:weather)).to eq mocked_forcast_object
      end

      it 'should return the cached value if it exists' do
        get :index, params: { query: '80211' }
        expect(assigns(:weather).from_cache).to eq false

        get :index, params: { query: '80211' }
        expect(assigns(:weather).from_cache).to eq true
      end

      it 'should not return the cache value if it has been more than 30 mins since last call' do
        Timecop.freeze(Time.now) do
          get :index, params: { query: '80211' }
          expect(assigns(:weather).from_cache).to eq false
        end

        # 1801 is 30 minutees in seconds
        Timecop.freeze(Time.now + 1801) do
          get :index, params: { query: '80211' }
          expect(assigns(:weather).from_cache).to eq false
        end
      end
    end

    describe "Invalid address input" do
      before do
        allow(mock_address_validator).to receive(:success?).and_return false
      end
      it 'raises an invalid address error when the address validator fails' do
        expect {  get :index, params: { query: '80211' } }.to raise_error(Exception)
      end
    end
  end
end