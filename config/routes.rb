# frozen_string_literal: true

Rails.application.routes.draw do
  post '/login', to: 'authentication#login'
  get 'exchange_rates', to: 'exchange_rates#fetch_todays_rates'
  get 'average_rate/:currency/:start/:end', to: 'exchange_rates#fetch_range_data'
  get 'average_rate/:currency/:date', to: 'exchange_rates#fetch_day_data'
end
