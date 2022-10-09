# frozen_string_literal: true

class Day < ApplicationRecord
  has_many :day_currencies
  has_many :currencies, through: :day_currencies
end
