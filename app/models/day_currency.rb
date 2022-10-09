# frozen_string_literal: true

class DayCurrency < ApplicationRecord
  belongs_to :day
  belongs_to :currency
end
