# frozen_string_literal: true

# Create ActiveRecord objects for data fetched from the external API
class AddExchangeRateForDatesJob < ApplicationJob
  queue_as :default

  def perform(body)
    body['rates'].each do |rate|
      code = body['code'].downcase
      day = Day.find_by_date(rate['effectiveDate']) || Day.create!(date: rate['effectiveDate'])
      create_day_currency(code, rate['mid'], day.id) if day.currencies.where(code:).empty?
    end
  end

  def create_day_currency(code, rate, day_id)
    currency_id = Currency.create!(code:, exchange_rate: rate * 10_000).id
    DayCurrency.create!(day_id:, currency_id:)
  end
end
