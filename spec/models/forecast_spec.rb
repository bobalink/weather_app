# frozen_string_literal: true

describe Forecast do
  let(:full_input_object) {
    {
      current_temperature: 63,
      weather_description: "Partly cloudy",
      feels_like: 64,
      weather_icons: [ "https://cdn.worldweatheronline.com/images/wsymbols01_png_64/wsymbol_0002_sunny_intervals.png" ],
      location_name: "Denver",
      region: "Colorado",
      wind_speed: 11,
      wind_dir: "NNW" }
  }

  let(:input_object_with_no_data) {
    {
      "location" => { "name" => nil, "country" => nil, "region" => nil },
      "current" => { "temperature" => nil,
                     "wind_speed" => nil,
                     "wind_dir" => nil,
                     "feels_like" => nil,
                     "weather_icons" => nil,
                     "weather_descriptions" => nil }
    }
  }


  describe 'initialize' do
    it 'assigns attributes based on input json returned from weatherstackapi' do
      forecast_obj = Forecast.new(full_input_object)
      expect(forecast_obj.current_temperature).to eq full_input_object[:current_temperature]
      expect(forecast_obj.weather_description).to eq full_input_object[:weather_description]
      expect(forecast_obj.feels_like).to eq full_input_object[:feels_like]
      expect(forecast_obj.weather_icons).to eq full_input_object[:weather_icons]
      expect(forecast_obj.wind_speed).to eq full_input_object[:wind_speed]
      expect(forecast_obj.wind_dir).to eq full_input_object[:wind_dir]
      expect(forecast_obj.location_name).to eq full_input_object[:location_name]
      expect(forecast_obj.region).to eq full_input_object[:region]
    end

    it 'populates a value for all provided input fields on the input object' do
      forecast_obj = Forecast.new(full_input_object)
      expect(forecast_obj.current_temperature).to_not be_nil
      expect(forecast_obj.weather_description).to_not be_nil
      expect(forecast_obj.feels_like).to_not be_nil
      expect(forecast_obj.weather_icons).to_not be_nil
      expect(forecast_obj.wind_speed).to_not be_nil
      expect(forecast_obj.wind_dir).to_not be_nil
      expect(forecast_obj.location_name).to_not be_nil
      expect(forecast_obj.region).to_not be_nil
    end

    it 'does not populate any null fields on the input object' do
      forecast_obj = Forecast.new(input_object_with_no_data)
      expect(forecast_obj.current_temperature).to be_nil
      expect(forecast_obj.weather_description).to be nil
      expect(forecast_obj.feels_like).to be nil
      expect(forecast_obj.weather_icons).to be nil
      expect(forecast_obj.wind_speed).to be nil
      expect(forecast_obj.wind_dir).to be nil
      expect(forecast_obj.location_name).to be nil
      expect(forecast_obj.region).to be nil
    end
  end
end
