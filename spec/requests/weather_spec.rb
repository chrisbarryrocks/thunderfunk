require 'rails_helper'
require_relative '../mock_data/mock_weather_data'

RSpec.describe "Weather", type: :request do
  describe "GET /weather" do
    location = "Cupertino, CA"
    mock_data  = MockWeatherData.data
    mock_data_location = mock_data["location"]

    before do
      allow(WeatherService).to receive(:fetch_weather)
        .with(location)
        .and_return([ mock_data, false ])
    end

    it "returns an HTTP success and renders the index template" do
      get weather_path, params: { location: location }

      expect(response).to have_http_status(:success)
      expect(response.body).to include("Current Weather for")
    end

    it "assigns the weather data correctly" do
      get weather_path, params: { location: location }

      html_body = Nokogiri::HTML(response.body)
      heading_text = html_body.at_css("h3").text
      temperature_paragraph = html_body.css("p").find { |p| p.text.include?("Temperature") }.text
      condition_paragraph = html_body.css(".condition-display").find { |p| p.text.include?("Condition") }.text

      expect(heading_text).to include("#{mock_data_location['name']}, #{mock_data_location['region']}, #{mock_data_location['country']}")
      expect(temperature_paragraph).to include("#{mock_data['current']['temp_f']}°F")
      expect(condition_paragraph).to include(mock_data['current']['condition']['text'])
    end

    it "displays an error if location is not provided" do
      get weather_path, params: { location: "" }

      expect(flash[:alert]).to eq("Please enter a valid location.")
      expect(response.body).to include("Please enter a valid location.")
    end

    it "displays an error if the weather service does not return valid weather data" do
      allow(WeatherService).to receive(:fetch_weather)
        .with("Invalid Location")
        .and_return([ nil, false ])

      get weather_path, params: { location: "Invalid Location" }

      expect(flash[:alert]).to eq("We weren’t able to retrieve weather for that location, please try again!")
      expect(response.body).to include("We weren’t able to retrieve weather for that location, please try again!")
    end
  end
end
