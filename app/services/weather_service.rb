class WeatherService
  include HTTParty
  base_uri "https://api.weatherapi.com/v1"

  CACHE_TTL = 30.minutes
  FORECAST_DAYS = 3

  def self.fetch_weather(location)
    result = Rails.cache.fetch(cache_key(location))
    cached = result.present?

    unless cached
      result = fetch_from_weather_service(location)

      if result.present?
        Rails.cache.write(cache_key(location), result, expires_in: CACHE_TTL)
      end
    end

    [ result, cached ]
  end

  def self.cache_key(location)
    "weather:#{location.downcase}"
  end

  def self.fetch_from_weather_service(location)
    response = get(
      "/forecast.json",
      query: { key: ENV.fetch("WEATHER_API_KEY"), q: location, days: FORECAST_DAYS }
    )

    unless response.success?
      Rails.logger.error(
        "WeatherService HTTP error for #{location}: status=#{response.code}, body=#{response.body}"
      )
      return nil
    end

    response.parsed_response
  end
end
