Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check

  get "/weather", to: "weather#index"
  get "/api/weather", to: "weather#fetch_weather_data"
end
