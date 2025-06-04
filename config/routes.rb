Rails.application.routes.draw do
  root to: proc { [ 200, {}, [ "Thunder Funk API" ] ] }
  get "/ping", to: proc { [ 200, {}, [ "Pong" ] ] }

  get "up" => "rails/health#show", as: :rails_health_check

  get "/weather", to: "weather#index"
  get "/api/weather", to: "weather#fetch_weather_data"
end
