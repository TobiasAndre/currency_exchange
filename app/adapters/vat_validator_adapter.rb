# frozen_string_literal: true

class VatValidatorAdapter
  VAT_INVALID_COUNTY_CODE = "N/A"
  CloudmersiveApiCallFailed = Class.new(StandardError)

  class << self
    def call(vat_code:)
      input = CloudmersiveValidateApiClient::VatLookupRequest.new
      input.vat_code = vat_code

      mapping_response(api_instance.vat_vat_lookup(input))
    rescue CloudmersiveValidateApiClient::ApiError
      raise CloudmersiveApiCallFailed
    end

    private

    attr_reader :vat_code

    def api_instance
      CloudmersiveValidateApiClient::VatApi.new
    end

    def mapping_response(api_response)
      country_code = api_response.is_valid ? api_response.country_code : VAT_INVALID_COUNTY_CODE

      { country_code: country_code }
    end
  end
end
