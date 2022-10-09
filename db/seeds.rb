# frozen_string_literal: true

User.create!(email: 'a@a.com', password: '121212')
Day.create!(date: '2021-10-09')
Day.create!(date: '2021-09-09')
Day.create!(date: '2021-09-10')
Currency.create!(code: 'usd', exchange_rate: '45000')
Currency.create!(code: 'usd', exchange_rate: '10000')
Currency.create!(code: 'usd', exchange_rate: '20000')
DayCurrency.create(day_id: 1, currency_id: 1)
DayCurrency.create(day_id: 2, currency_id: 2)
DayCurrency.create(day_id: 3, currency_id: 3)
