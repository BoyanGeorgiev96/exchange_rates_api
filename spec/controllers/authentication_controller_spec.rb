# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AuthenticationController, type: :request do
  describe 'POST login' do
    it 'logins successfully' do
      user = create(:user)
      post login_path, params: { "email": user.email, "password": user.password, format: 'json' }
      expect(json(response)['token'].present?).to be true
      expect(response.status).to eq(200)
    end

    it "doesn't login with invalid user" do
      post login_path, params: { "email": 'not_valid', "password": 'not_valid', format: 'json' }
      expect(json(response)['token'].present?).to be false
      expect(response.status).to eq(401)
    end

    it 'raises NotFound error when wrong token is provided' do
      get '/average_rate/usd/2021-09-09/2021-09-10', headers: invalid_auth
      expect(response.status).to eq(404)
    end
  end
end
