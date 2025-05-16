module MockWeatherData
  def self.data
    {
      "location" => {
        "name" => "Cupertino",
        "region" => "California",
        "country" => "United States"
      },
      "current" => {
        "temp_c" => 20,
        "temp_f" => 68,
        "condition" => {
          "text" => "Sunny",
          "icon" => "//cdn.weatherapi.com/weather/64x64/day/113.png"
        },
        "humidity" => 50,
        "wind_mph" => 5
      },
      "forecast" => {
        "forecastday" => [
          {
            "date" => "2025-05-17",
            "day" => {
              "maxtemp_f" => 70.0,
              "mintemp_f" => 60.0,
              "condition" => {
                "text" => "Sunny",
                "icon" => "//cdn.weatherapi.com/weather/64x64/day/113.png"
              }
            }
          }
        ]
      }
    }
  end
end
