# frozen_string_literal: true

describe Forecast do

  let(:full_input_object) {
    {
      "location" => { "name" => "Denver", "country" => "USA", "region" => "Colorado"},
      "current" => { "temperature" => 63,
                     "feelslike" => 64,
                     "wind_speed" => 11,
                      "wind_dir" => "NNW",
                     "weather_icons" => ["https://cdn.worldweatheronline.com/images/wsymbols01_png_64/wsymbol_0002_sunny_intervals.png"],
                     "weather_descriptions" => ["Partly cloudy"] },
    }
  }

  let(:input_object_with_no_data) {
    {
      "location" => { "name" => nil, "country" => nil, "region" => nil},
      "current" => { "temperature" => nil,
                     "wind_speed" => nil,
                     "wind_dir" => nil,
                     "feelslike" => nil,
                     "weather_icons" => nil,
                     "weather_descriptions" => nil },
    }
  }


  describe 'initialize' do
    it 'assigns attributes based on input json returned from weatherstackapi' do
      forecast_obj = Forecast.new(full_input_object)
      expect(forecast_obj.current_temperature).to eq full_input_object['current']['temperature']
      expect(forecast_obj.weather_description).to eq full_input_object['current']['weather_descriptions'].first
      expect(forecast_obj.feelslike).to eq full_input_object['current']['feelslike']
      expect(forecast_obj.weather_icons).to eq full_input_object['current']['weather_icons']
      expect(forecast_obj.wind_speed).to eq full_input_object['current']['wind_speed']
      expect(forecast_obj.wind_dir).to eq full_input_object['current']['wind_dir']
      expect(forecast_obj.location_name).to eq full_input_object['location']['name']
      expect(forecast_obj.region).to eq full_input_object['location']['region']
    end

    it 'populates a value for all provided input fields on the input object' do
      forecast_obj = Forecast.new(full_input_object)
      expect(forecast_obj.current_temperature).to_not be_nil
      expect(forecast_obj.weather_description).to_not be_nil
      expect(forecast_obj.feelslike).to_not be_nil
      expect(forecast_obj.weather_icons).to_not be_nil
      expect(forecast_obj.wind_speed).to_not be_nil
      expect(forecast_obj.wind_dir).to_not be_nil
      expect(forecast_obj.location_name).to_not be_nil
      expect(forecast_obj.region).to_not be_nil
    end

    it 'does not populate null fields on the input object' do
      forecast_obj = Forecast.new(input_object_with_no_data)
      expect(forecast_obj.current_temperature).to be_nil
      expect(forecast_obj.weather_description).to be nil
      expect(forecast_obj.feelslike).to be nil
      expect(forecast_obj.weather_icons).to be nil
      expect(forecast_obj.wind_speed).to be nil
      expect(forecast_obj.wind_dir).to be nil
      expect(forecast_obj.location_name).to be nil
      expect(forecast_obj.region).to be nil
    end
  end
end