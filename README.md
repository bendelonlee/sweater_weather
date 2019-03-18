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

## Deploying

Deployed here: https://fast-inlet-92320.herokuapp.com/

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
