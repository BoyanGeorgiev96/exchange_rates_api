# README

### Ruby version - 3.1.0

### Rails version - 7.0.4

## Project setup

Clone the repository and install the gems:

```
git clone https://github.com/BoyanGeorgiev96/exchange_rates_api.git
cd exchange_rates_api
bundle
```

## Database initialization 

`rails db:setup`

## Daily rate fetching

In the root directory run (assuming a UNIX system):

`whenever --update-crontab`

This adds a cron task to be executed daily. The cron task calls the DailyExchangeRates.fetch_todays_rates method.

You can check if the task has been added successfully by checking the output of:

`crontab -l`

It should contain something like the following:

`0 0 * * * /bin/bash -l -c 'cd /home/user/currency_exchange_rate && bundle exec bin/rails runner -e development '\''DailyExchangeRates.fetch_todays_rates'\'''`

## API Usage

Run the server:
`rails s`

The following requests can be executed via tools such as [Postman](https://www.postman.com).

### Login request

`POST http://127.0.0.1:3000/login with body email: "a@a.com", password: "121212"`

Expected response - token used for other queries and expiration datetime

### Fetch local data for a range of dates

`GET http://127.0.0.1:3000/average_rate/usd/2021-09-09/2021-09-10 with header { 'Authorization': "Bearer #{token}" }`

Expected response - 1.5000

### Fetch local data for a specific day

`GET http://127.0.0.1:3000/average_rate/usd/2022-10-07 with header { 'Authorization': "Bearer #{token}" }`

Expected response - 4.9588

### Fetch external API data for a range of dates

`GET http://127.0.0.1:3000/average_rate/usd/2022-09-09/2022-09-15 with header { 'Authorization': "Bearer #{token}" }`

Expected response - 4.6724

### Fetch external API data for a specific day

`GET http://127.0.0.1:3000/average_rate/usd/2022-10-05 with header { 'Authorization': "Bearer #{token}" }`

Expected response - 4.8380


## Run Test suite

A minimal test seed is provided to showcase the usage of the exact queries above

Navigate to the project root folder and run:

`rspec`

## Future development

* Average exchange rate for the last n days

* Average exchange rate for the last n records (Seems like the external API does not have values for weekends)

* Buy/sell rates

* Average/buy/sell rates for multiple currencies

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/BoyanGeorgiev96/exchange_rates_api.
