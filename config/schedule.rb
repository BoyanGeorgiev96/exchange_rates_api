# frozen_string_literal: true

set :environment, 'development'

every 1.day do
  runner 'DailyExchangeRates.fetch_todays_rates'
end
