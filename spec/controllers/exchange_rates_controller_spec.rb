require 'rails_helper'

RSpec.describe ExchangeRatesController, type: :request do

  describe "get 'average_rate/:currency/:date'" do
    it 'returns local average for a single date' do
      get '/average_rate/usd/2021-10-09', headers: auth_header
      expect(response.body).to eq('4.5000')
      expect(response.status).to eq(200)
    end
  end

  describe "get 'average_rate/:currency/:start/:end'" do
    it 'returns local average for a single date' do
      get '/average_rate/usd/2021-09-09/2021-09-10', headers: auth_header
      expect(response.body).to eq('1.5000')
      expect(response.status).to eq(200)
    end
  end
end
