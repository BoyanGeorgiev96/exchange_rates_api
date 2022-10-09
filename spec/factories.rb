# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    email { 'a@a.com' }
    password { '121212' }
  end
end
