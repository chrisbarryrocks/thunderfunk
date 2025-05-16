
# Thunder Funk

Thunder Funk is a weather-driven vibe application built with Ruby on Rails. 
It retrieves real-time weather data for a specified location, caches it for 30 minutes, and plays a funk/jazz soundtrack based on the weather conditions.
We use [WeatherAPI](https://www.weatherapi.com/) to fetch weather data. To run this locally, you will need a valid API Key. Follow the setup instructions below.

---

## Getting Started

### Prerequisites
- Ruby 3.1+
- Rails 7+
- Redis (Optional)

### Installation

1. **Clone the repository:**
```
git clone https://github.com/chrisbarry00/thunderfunk.git
cd thunderfunk
```

2. **Install dependencies:**
```
bundle install
```

3. **Set up the database:**
```
rails db:setup
```

4. **Run the server:**
```
rails server
```

5. **Visit the application:**
Open your browser and navigate to:
```
http://localhost:3000/weather
   ```

---

## Environment Variables

Create a `.env` file in the project root with the following:
```
WEATHER_API_KEY=your_api_key_here
REDIS_URL=redis://localhost:6379/1
```

---

## Running Tests

To execute the test suite:
```
bundle exec rspec
```

---

## Caching

If the `REDIS_URL` environment variable is set and Redis is running at that address, caching is done via Redis.
If we can't connect to a Redis instance, we'll fall back to Rails MemoryStore.