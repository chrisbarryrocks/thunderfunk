require 'rails_helper'
require 'webmock/rspec'
require_relative '../mock_data/mock_weather_data'

RSpec.describe WeatherService do
  API_URL = 'https://api.weatherapi.com/v1/forecast.json'
  FORECAST_DAYS = 3
  LOCATION = 'Cupertino, CA'
  RAW_JSON = MockWeatherData.data.to_json

  cache_store = ActiveSupport::Cache::MemoryStore.new
  mock_data = JSON.parse(RAW_JSON)

  before do
    allow(Rails).to receive(:cache).and_return(cache_store)
    cache_store.clear
  end

  def stub_success(location)
    stub_request(:get, API_URL)
      .with(query: { key: ENV.fetch('WEATHER_API_KEY'), q: location, days: FORECAST_DAYS })
      .to_return(status: 200, body: RAW_JSON, headers: { 'Content-Type' => 'application/json' })
  end

  def stub_failure(location)
    stub_request(:get, API_URL)
      .with(query: { key: ENV.fetch('WEATHER_API_KEY'), q: location, days: FORECAST_DAYS })
      .to_return(status: 404, body: 'Not Found')
  end

  describe 'fetch_weather' do
    it 'returns weather data and indicates we did not get cached data on initial call' do
      stub_success(LOCATION)
      result, cached = WeatherService.fetch_weather(LOCATION)

      expect(result['location']['name']).to eq(mock_data['location']['name'])
      expect(result['current']['temp_f']).to eq(mock_data['current']['temp_f'])
      expect(result['forecast']['forecastday'][0]['date'])
        .to eq(mock_data['forecast']['forecastday'][0]['date'])
      expect(cached).to eq(false)
    end

    it 'indicates we DID get data from cache on the second call' do
      stub_success(LOCATION)
      WeatherService.fetch_weather(LOCATION)
      _, cached = WeatherService.fetch_weather(LOCATION)

      expect(cached).to eq(true)
    end

    it 'returns no weather data when WeatherService API call fails' do
      stub_failure('Invalid Location')
      result, cached = WeatherService.fetch_weather('Invalid Location')

      expect(result).to be_nil
      expect(cached).to eq(false)
    end
  end
end
