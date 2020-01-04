# frozen_string_literal: true

class DailyQuoteAdapter
  API_URL = Rails.application.credentials[Rails.env.to_sym][:currency_api_url]
  API_KEY = Rails.application.credentials[Rails.env.to_sym][:currency_api_key]

  QuoteUnavailable = Class.new(StandardError)

  class << self
    def call(source_currency:, target_currency:)
      raw_response = RestClient.get(service_url(source_currency, target_currency))
      current_quote = JSON.parse(raw_response.body)["currency"][0]["value"].to_f

      current_quote
    rescue RestClient::ExceptionWithResponse
      raise QuoteUnavailable
    end

    private

    def service_url(source_currency, target_currency)
      "#{API_URL}?token=#{API_KEY}&currency=#{source_currency}/#{target_currency}"
    end
  end
end
