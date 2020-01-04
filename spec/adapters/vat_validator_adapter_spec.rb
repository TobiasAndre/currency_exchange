# frozen_string_literal: true

require "rails_helper"

describe VatValidatorAdapter do
  subject(:validation_response) { described_class.call(params) }

  let(:params) { { vat_code: vat_code } }

  describe "#call" do
    context "when VAT is valid" do
      let(:vat_code) { "CZ25123891" }
      let(:expected_response) { { country_code: "CZ" } }

      it "returns the correct country code", :vcr do
        expect(validation_response).to be_eql(expected_response)
      end
    end

    context "when VAT is invalid" do
      let(:vat_code) { "1235" }
      let(:expected_response) { { country_code: "N/A" } }

      it "returns country code not available", :vcr do
        expect(validation_response).to be_eql(expected_response)
      end
    end

    context "when API call fails" do
      before do
        allow(CloudmersiveValidateApiClient::VatApi).to(
          receive(:new).and_return(mocked_vat_api)
        )
        allow(mocked_vat_api).to(
          receive(:vat_vat_lookup).and_raise(CloudmersiveValidateApiClient::ApiError)
        )
      end
      let(:vat_code) { "CZ25123891" }
      let(:mocked_vat_api) { instance_double("CloudmersiveValidateApiClient::VatApi") }

      it "raises CloudmersiveApiCallFailed", :vcr do
        expect { validation_response }.to raise_error(VatValidatorAdapter::CloudmersiveApiCallFailed)
      end
    end
  end
end
