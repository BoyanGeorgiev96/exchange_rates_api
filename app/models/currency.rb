# frozen_string_literal: true

class Currency < ApplicationRecord
  has_many :day_currencies
  has_many :days
end
