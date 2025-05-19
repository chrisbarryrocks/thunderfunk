class WeatherController < ApplicationController
  before_action :ensure_submitted, only: :index

  def index
    if location.blank?
      flash.now[:alert] = "Please enter a valid location."
      return render :index
    end

    weather_data, @cached = WeatherService.fetch_weather(location)

    if weather_data.nil?
      flash.now[:alert] = "We weren’t able to retrieve weather for that location, please try again!"
      return render :index
    end

    prepare_weather(weather_data)
    render :index
  end

  def fetch_weather_data
    if location.blank?
      render json: { error: "Please enter a valid location." }, status: :bad_request
      return
    end

    weather_data, cached = WeatherService.fetch_weather(location)

    if weather_data.nil?
      render json: { error: "We weren’t able to retrieve weather for that location, please try again!" }, status: :not_found
      return
    end

    render json: {
      weather: weather_data,
      cached: cached
    }, status: :ok
  end

  private

  def ensure_submitted
    render :index unless submitted?
  end

  def location
    params.permit(:location)[:location].to_s.strip
  end

  def prepare_weather(weather_data)
    prepare_current_weather(weather_data.fetch("current", {}))
    prepare_extended_forecast(weather_data.fetch("forecast", {}).fetch("forecastday", []))
    prepare_location(weather_data.fetch("location", {}))
    prepare_vibes()
  end

  def prepare_current_weather(current)
    @temp_c = current["temp_c"]
    @temp_f = current["temp_f"]
    @condition_icon = current.dig("condition", "icon")
    @condition_text = current.dig("condition", "text")
    @humidity = current["humidity"]
    @wind_mph = current["wind_mph"]
  end

  def prepare_extended_forecast(forecast_days)
    @forecast_days = forecast_days.map do |day|
      {
        date: day["date"],
        high_temp: day.dig("day", "maxtemp_f"),
        low_temp: day.dig("day", "mintemp_f"),
        condition_text: day.dig("day", "condition", "text"),
        condition_icon: day.dig("day", "condition", "icon")
      }
    end
  end

  def prepare_vibes
    if @condition_text.present?
      @vibes = ThunderFunkVibesService.get_vibes(@condition_text)
    end
  end

  def prepare_location(location_data)
    @location = [ location_data["name"], location_data["region"], location_data["country"] ].join(", ")
  end

  def submitted?
    params.key?(:location)
  end
end
