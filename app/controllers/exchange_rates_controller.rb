# frozen_string_literal: true

# Renders exchange rates according to user-supplied parameters
class ExchangeRatesController < ApplicationController
  before_action :authorize_request

  # Fetches data for exchange rates between two dates
  def fetch_range_data
    day_ids = day_ids_between_dates
    rates = day_ids.present? ? find_rates(day_ids) : fetch_external_range_rates
    average = rate_average(rates)
    render json: average
  end

  # Fetches data for exchange rates for a day
  def fetch_day_data
    day = Day.find_by_date(params[:date])
    rate = currency_exists_for_day?(day) ? find_local_day_rate(day) : fetch_external_day_rate
    render json: rate
  end

  def currency_exists_for_day?(day)
    day && day.currencies.where(code: params[:currency]).present?
  end

  def find_local_day_rate(day)
    format('%.4f', day.currencies.where(code: params[:currency].downcase)[0].exchange_rate.to_f / 10_000)
  end

  def fetch_external_day_rate
    res = Query.new([params[:currency], params[:date]]).response

    # Save response to database for future searches
    AddExchangeRateForDatesJob.set(wait: 3.seconds).perform_later(res)
    format('%.4f', res['rates'][0]['mid'])
  end

  def day_ids_between_dates
    Day.where(date: params[:start]..params[:end]).pluck(:id)
  end

  def fetch_external_range_rates
    res = Query.new([params[:currency], params[:start], params[:end]]).response

    # Save response to database for future searches
    AddExchangeRateForDatesJob.set(wait: 3.seconds).perform_later(res)
    rates_array(res['rates'])
  end

  def rates_array(rates)
    arr = []
    rates.each do |rate|
      arr << Integer(rate['mid'] * 10_000)
    end
    arr
  end

  def find_rates(day_ids)
    Currency.includes(:day_currencies)
            .where(day_currencies: { day_id: day_ids })
            .where(code: params[:currency])
            .pluck(:exchange_rate)
  end

  def rate_average(rates)
    format('%.4f', (rates.sum.to_f / rates.size / 10_000).round(4))
  end
end
