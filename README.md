# Sweater Weather Backend

## Introduction

Welcome to Sweater Weather, a backend API serving weather information. Users can search for weather by city, as well as register and save cities to their favorites.

Any city that is searched for is stored in the database. Forecasts are refreshed by rake scheduled rake task (They can go a day without refreshing, though weather data loses accuracy).

Google Geocoder is hit once per city search ("denver" and "denver, co" are two separate search), but every time a search is made again, redis points to the correct city, and no extra API calls are required.

Google Timezones is hit as well.

## Production URL

http://sweater-weather-1.surge.sh/

## Initial Setup

1. Clone down. From the command line:
```
git clone git@github.com:bendelonlee/sweater_weather.git
```
2. From the command line, run `bundle install` (if you have bundler).

3. Ensure that a backend application is running and sending requests to the address contained in the variable backendAddress. The backend application is found here: https://github.com/bendelonlee/sweater_weather

## Deployment

Deployed here: https://fast-inlet-92320.herokuapp.com

## Endpoints

#### Forecast

Example request:

```
GET /api/v1/forecast?location=Denver
```

Example response:

```
{
"id": 3723,
"day_summary": "Partly cloudy throughout the day.",
"week_summary": "Possible light rain on Wednesday, with high temperatures peaking at 97°F on Sunday.",
"current_hour": {
"timezone_offset": -21600,
"icon": "partly-cloudy-day",
"summary": "Partly Cloudy",
"time": "2019-08-16T18:00:00.000+00:00",
"temperature": 91,
"feels_like": 90.72,
"humidity": 0.13,
"visibility": 10,
"uv_index": 8
},
"current_day": {
"icon": "partly-cloudy-day",
"summary": "Partly cloudy throughout the day.",
"time": "2019-08-16",
"high": 93,
"low": 60,
"precip_probability": 0.15,
"precip_type": "rain"
},
"hours": [
{
"temperature": 91,
"time_of_day": "12 PM",
"icon": "partly-cloudy-day"
},
... 19 more ...
],
"days": [
{
"icon": "partly-cloudy-day",
"day_of_week": "Friday",
"high": 93,
"low": 60,
"precip_probability": "15%",
"precip_type": "rain"
},
... 7 more ...
}
```

#### Background


Example request:

```
GET /api/v1/background?location=Denver
```

Example response:

```
  {
  "source": "https://farm8.staticflickr.com/7024/6500600405_cc6dab682a_b.jpg"
  }
```

### Gifs

Example Request:

```
GET /api/v1/gifs?location=Denver
```

Example Response:

```
{
"data": {
"days": [
{
"summary": "Partly cloudy throughout the day.",
"time": "2019-08-16",
"gif_url": "https://giphy.com/embed/aQ7kognlRPDzi"
},
... 7 more ...
]
},
"copyright": 2019
}
```

### User creation

Example Request:

```
POST /api/v1/users?email=abc@mail.com&password=123&password_confirmation=123
```

Example Response:

```
{api_key: "eyJhbGciOiJIUzI1NiJ9.eyJleHAiOjE1NjYwNjg2NjgsImlkIjo1OH0.-cwKEnFmqGXGcaxMjuf42-6OdR1MG2yG42e1BqZ6B5Y"}
```

### Session creation

Example Request:

```
POST /api/v1/sessions?email=44&password=44
```

Example Response:

```
{api_key: "eyJhbGciOiJIUzI1NiJ9.eyJleHAiOjE1NjYwNjkwMzcsImlkIjo2fQ.xoM9Vwam60KHCQSPoNSDnXuT3Fsce4Zd9WHT4BNDnmA"}
```

### Favorite creation

Example Request:

```
POST /api/v1/favorites?api_key=eyJhbGciOiJIUzI1NiJ9.eyJleHAiOjE1NjYwNjg2NjgsImlkIjo1OH0.-cwKEnFmqGXGcaxMjuf42-6OdR1MG2yG42e1BqZ6B5Y&city_id=1
```

Example Response:

```
{success: "City Denver added to your favorites"}
```

### Favorite index


Example Request:

```
GET /api/v1/favorites?api_key=eyJhbGciOiJIUzI1NiJ9.eyJleHAiOjE1NjYwNjkyNjUsImlkIjo2fQ.6PNJblSQvbGX5_rL1HIaSpcdVcATeIaV4hyMaCJoCG8
```

Example Response:

```
[
    {
        "id": 1,
        "name": "Denver",
        "state": "CO",
        "country": "United States",
        "current_weather": {
            "timezone_offset": -21600,
            "icon": "partly-cloudy-day",
            "summary": "Partly Cloudy",
            "time": "2019-08-16T19:00:00.000+00:00",
            "temperature": 93,
            "feels_like": 92.64,
            "humidity": 0.11,
            "visibility": 10,
            "uv_index": 9
        }
    },
    ... more cities ...
]
```

### Favorite destroy


Example Request:

```
DELETE /api/v1/favorites?api_key=eyJhbGciOiJIUzI1NiJ9.eyJleHAiOjE1NjYwNjkyNjUsImlkIjo2fQ.6PNJblSQvbGX5_rL1HIaSpcdVcATeIaV4hyMaCJoCG8&city_id=1
```

Example Response:

```
{
    "id": 1,
    "name": "Denver",
    "state": "CO",
    "country": "United States",
    "current_weather": {
        "timezone_offset": -21600,
        "icon": "partly-cloudy-day",
        "summary": "Partly Cloudy",
        "time": "2019-08-16T19:00:00.000+00:00",
        "temperature": 93,
        "feels_like": 92.64,
        "humidity": 0.11,
        "visibility": 10,
        "uv_index": 9
    }
}
```







## Tech Stack

* [Rails](https://rubyonrails.org/)
* [PostgreSQL](https://www.postgresql.org/)
* [Redis](https://redis.io/)

## Known Issues

There is an inefficient amount of converting between objects and storage when a forecast is first searched for. It is fetched, this data is turned into POROs. Theses POROs are stored as JSONb. This JSONb is then re-rendered into identical POROs, when the original POROs could have been used instead.

When daylight savings time starts or ends, the timezone_offset stored in the database will for many cities will be invalid.

Not all international cities are parsed correctly for their state and country.

There is no graceful handling for when Darksky doesn't return expected weather data. Has been noticed for cities in Asia and Africa.

## How to Contribute

Send a pull request to git@github.com:bendelonlee/sweater_weather.git

## Core Contributors

Ben Lee

## Special Thanks

* [Sal Espinosa](https://github.com/s-espinosa)
* [Mike Dao](https://github.com/mikedao)
