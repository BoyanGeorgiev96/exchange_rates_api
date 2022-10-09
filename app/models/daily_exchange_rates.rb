# frozen_string_literal: true

# Daily fetching of exchange rates for USD and EUR
class DailyExchangeRates
  def self.fetch_todays_rates
    day = Day.create!(date: Date.today.to_s)
    %w[usd eur].each do |currency|
      res = Query.new([currency]).response
      create_daily_rates(res, currency, day.id)
    end
  end

  def self.create_daily_rates(res, code, day_id)
    exchange_rate = res['rates'][0]['mid'] * 10_000
    currency_id = Currency.create!(code:, exchange_rate:).id
    DayCurrency.create!(currency_id:, day_id:)
  end
end
