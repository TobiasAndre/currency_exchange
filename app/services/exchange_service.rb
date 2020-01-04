# frozen_string_literal: true

class ExchangeService
  def initialize(source_currency:, target_currency:, amount:)
    @source_currency = source_currency
    @target_currency = target_currency
    @amount = amount.to_f
  end

  def perform
    value = DailyQuoteAdapter.call(
      source_currency: source_currency,
      target_currency: target_currency
    )

    (value * amount).round(2)
  end

  private

  attr_reader :source_currency, :target_currency, :amount
end
