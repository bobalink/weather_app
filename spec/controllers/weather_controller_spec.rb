# frozen_string_literal: true
require 'rails_helper'
# require 'rspec'

describe WeatherController, type: :controller do
  let(:http_mock) { class_double(Net::HTTP) }

  before do
    allow(http_mock).to receive(:get_response)

    # allow(team).to receive(:players).and_return([double(:name => "David")])
  end

  it "should run a spec" do
    expect(true).to eq true
  end

  it "should call the weatherstack api" do
    get :index
    expect(response).to have_http_status(:ok)

  end

end