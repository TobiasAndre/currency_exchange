# frozen_string_literal: true

class ValidatorsController < ApplicationController
  def validate_vat
    return params_missing? if empty_params?

    vat_validation_response = Rails.cache.fetch(cache_key, expires_in: 1.day) do
      VatValidatorAdapter.call(vat_code: params[:vat_code])
    end

    render json: vat_validation_response
  rescue VatValidatorAdapter::CloudmersiveApiCallFailed
    render json: { error: "API call failed" }, status: :internal_server_error
  end

  private

  def empty_params?
    params[:vat_code].blank?
  end

  def params_missing?
    render json: { "message": "all parameters are required" }, status: :unprocessable_entity
  end

  def vat_code
    params[:vat_code]
  end

  def cache_key
    vat_code
  end
end
