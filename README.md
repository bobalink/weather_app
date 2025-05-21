# Overview

This is a Ruby on rails app designed to take an address an input and return the current weather for that location. 
It will cache results for a zip code for 30 minutes

## Data Sources:
* Weather data: https://weatherstack.com/
* Address validation: https://www.smarty.com/

## Setup
  ### Ruby Version

- 3.4.2

I chose to use [rbenv](https://github.com/rbenv/rbenv) to handle the the ruby environment

`bundle install`
`rails s`

### Running tests
  
run `rspec` in the directory

### Credentials 
The API keys for the two different data sources are stored in `config/credentials.yml.enc` however that file is encrypted 
with a master key. If you have the master key you can create a file `config/master.key` and include that master key there


If you do not have a master key you'll need to create your own account at both [weatherstack](https://weatherstack.com/) 
and [smartly](https://www.smarty.com/) and get the keys for both of them and then add them to your own credential file

You can do this by running

`EDITOR="code --wait" rails credentials:edit` 

and then edit the yaml to store your new credentials

it should look something like this when you are done

     smarty:
        auth_id: "<smarty_auth_id_here>"
        auth_token: "<smarty_auth_token_here>"

     weatherstack:
        api_key: "<weatherstack_api_key_here>"

## Main files to review

### Controllers
  - [Forecast Controller](app/controllers/forecast_controller.rb)
  - [Forecast Controller tests](spec/controllers/forecast_controller_spec.rb)

### Services 
  - [Forecast_Service](app/services/forecast_service.rb)
  - [Forecast Service Tests](spec/services/forecast_service_spec.rb)

### Models
  - [Forecast](app/models/forecast.rb)


#### Forecast model fields
  -  current_temperature (Integer): The current temperature of give address
  -  from_cache (Boolean): an indicator of if the result was returned from cache
  -  feels_like (Integer): What the current temperature for the given address feels like given wind and humidity
  -  location_name (String): The name of the city of the provided address
  -  region (String): The name of the State or Region of the provided address
  -  weather_description (String): a description of the current weather of the address provided
  -  weather_icons ([String]): an array of strings that are URLs to a weather icons
  -  wind_dir(String): a string representing the wind direction at the provided address
  -  wind_speed(Integer):  a representation of how fast the wind is blowing at the provided address in MPH
  

## Considerations
### Design considerations

- In the forecast controller I chose to only use the validated zip rather than the full validated address to help limit the number of mocks needed to test it.
  In a prod situation I would aim for the full address but given that we are returning the cached value of the zip anyway
  it felt like a reasonable way to achieve results faster with minimal downsides

## Potential next steps

### Improve Error handling
 Currently any error routes you to the default rails error page. Ideally we would be popping up some alert that provided 
additional information on what the user could do to resolve the issue

### Abstract Address Validation
 Currently the address validation is currently in the forecast controller but ideally this would live in it's own service

### Autofill address on frontend
 
 Currently the address input is just a free text field. It would be beneficial to the user if there was an address autofill
on the front end to reduce chances of bad input.




Things still to do:
- write documentation
  - Update Service to do parsing of object
  - How to update credentials and where they come from
  - Potentially design patters
  - Design Decisions
    - Returning null values for specific fields when they don't exist
    - 
  - Things I would work on next
    - Address autofill for the FE
    - Object factories for test
- Work on stripping zip from input to cache based on that




