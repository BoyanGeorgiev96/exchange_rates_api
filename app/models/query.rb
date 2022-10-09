# frozen_string_literal: true

# External API calls with error reporting
class Query
  attr_accessor :response

  def initialize(routes)
    uri = URI("http://api.nbp.pl/api/exchangerates/rates/a/#{routes.join('/')}")
    params = { format: 'json' }
    uri.query = URI.encode_www_form(params)
    res = Net::HTTP.get_response(uri)
    raise Exceptions::NotFound, res.body if res.is_a? Net::HTTPNotFound
    raise Exceptions::BadRequest, res.body if res.is_a? Net::HTTPBadRequest

    self.response = parsed_body(res.body)
  end

  def parsed_body(body)
    JSON.parse(body)
  end
end
