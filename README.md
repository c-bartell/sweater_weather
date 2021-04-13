# Sweater Weather AKA Whether Sweater?
[![Build Status](https://travis-ci.com/travis-ci/travis-web.svg?branch=master)](https://travis-ci.com/github/c-bartell/sweater_weather)
---
Sweater weather is a service oriented API meant to be the back end for a road trip planning app. Endpoints are available to get weather data and pictures for a location, register and login users, and fetch weather data for the time of arrival at trip destinations.

---
### Getting Started:
To get started with the API, first clone this repo to your local machine, then run `$ bundle install`, `$ figaro install` and `$ bundle exec rake db:{create,migrate}`. To make use of the API, you will first need to obtain API keys for the [MapQuest API](https://developer.mapquest.com/documentation/), [Unsplash API](https://unsplash.com/documentation#getting-started), and [OpenWeather API](https://openweathermap.org/api), then add them to your `application.yml` file. Finally, run `$ rails s` to start your local server and start making calls to the available endpoints!

___
### Endpoints
If you are running sweater weather with `$ rails s`, the root url will be `localhost:3000`.

**The following headers should be included on all API calls:**
```
Content-Type: application/json
Accept: application/json
```
##### Forecasts
```
GET /api/v1/forecast?location=<LOCATION>
```
Response:
```
{
  "data": {
    "id": null,
    "type": "forecast",
    "attributes": {
      "current_weather": {
        "datetime": "2020-09-30 13:27:03 -0600",
        "temperature": 79.4,
        etc
      },
      "daily_weather": [
        {
          "date": "2020-10-01",
          "sunrise": "2020-10-01 06:10:43 -0600",
          etc
        },
        {...} etc
      ],
      "hourly_weather": [
        {
          "time": "14:00:00",
          "wind_speed": "4 mph",
          "wind_direction": "from NW",
          etc
        },
        {...} etc
      ]
    }
  }
}
```

##### Location Backgrounds
```
GET /api/v1/backgrounds?location=<LOCATION>
```
Response:
```
{
  "data": {
    "type": "image",
    "id": null,
    "attributes": {
      "image": {
        "location": "...",
        "image_url": "..."
        "alt_description": "..."
        "credit": {...}
      }
    }
  }
}
```
##### User Registration
```
POST /api/v1/users
Body:
{
  "email": "whatever@example.com",
  "password": "password",
  "password_confirmation": "password"
}
```
Response:
```
{
  "data": {
    "type": "users",
    "id": "1",
    "attributes": {
      "email": "whatever@example.com",
      "api_key": "jgn983hy48thw9begh98h4539h4"
    }
  }
}
```
##### User Login
```
POST /api/v1/sessions
Body:
{
  "email": "whatever@example.com",
  "password": "password"
}
```
Response:
```
{
  "data": {
    "type": "users",
    "id": "1",
    "attributes": {
      "email": "whatever@example.com",
      "api_key": "jgn983hy48thw9begh98h4539h4"
    }
  }
}
```
##### Road Trip
```
POST /api/v1/road_trip
Body:
{
  "origin": "Denver,CO",
  "destination": "Pueblo,CO",
  "api_key": "jgn983hy48thw9begh98h4539h4"
}
```
Response:
```
{
  "data": {
    "id": null,
    "type": "roadtrip",
    "attributes": {
      "start_city": "Denver, CO",
      "end_city": "Estes Park, CO",
      "travel_time": "2 hours, 13 minutes"
      "weather_at_eta": {
        "temperature": 59.4,
        "conditions": "partly cloudy with a chance of meatballs"
      }
    }
  }
}
```

If you would like to try sending requests to the deployed API, Sweater Weather is deployed at https://curtis-sweater-weather.herokuapp.com/.
___

### Built with
* Rails `5.2.4.3`
* Ruby `2.5.3`
* PostgreSQL 13
* MapQuest API
* Unsplash API
* OpenWeather API

### Authors
* Sweater Weather: Lovingly coded by Curtis Bartell [GitHub](https://github.com/c-bartell)|[Twitter](https://twitter.com/curtis_codes)|[LinkedIn](https://www.linkedin.com/in/curtis-bartell/)
* [Project Requirements](https://backend.turing.io/module3/projects/sweater_weather/requirements): Turing School of Software and Design
