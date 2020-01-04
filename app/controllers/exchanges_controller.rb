# frozen_string_literal: true

class ExchangesController < ApplicationController
  def convert_currencies
    return params_missing? if empty_params?

    value = Rails.cache.fetch(cache_key, expires_in: 1.hour) do
      ExchangeService.new(exchange_params).perform
    end

    render json: { "generated_at": DateTime.current, "value": value }
  rescue DailyQuoteAdpater::QuoteUnavailable
    render json: { error: "Quote not found", value: 0 }, status: :unprocessable_entity
  end

  private

  def empty_params?
    params[:source_currency].blank? || params[:target_currency].blank? || params[:amount].blank?
  end

  def params_missing?
    render json: { "message": "all parameters are required" }, status: :unprocessable_entity
  end

  def exchange_params
    {
      source_currency: params.dig(:source_currency),
      target_currency: params.dig(:target_currency),
      amount: params.dig(:amount)
    }
  end

  def cache_key
    "#{params.dig(:source_currency)}-#{params.dig(:target_currency)}-#{params.dig(:amount)}"
  end
end
