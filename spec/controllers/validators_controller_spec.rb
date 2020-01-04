# frozen_string_literal: true

require "rails_helper"

describe ValidatorsController, type: :request do
  describe "#validate_vat" do
    context "when params is missing" do
      it "return unprocessable entity (422)", :vcr do
        get "/api/validators/validate_vat", params: {}
        expect(response).to have_http_status(422)
      end
    end

    context "when invalid parameters are passed" do
      it "then returns a invalid country code", :vcr do
        get "/api/validators/validate_vat", params: { vat_code: "CZ25123" }

        expect(response).to have_http_status(200)
        expect(JSON.parse(response.body)).to eq("country_code" => "N/A")
      end
    end

    context "when valid params" do
      it "returns a valid country code", :vcr do
        get "/api/validators/validate_vat", params: { vat_code: "CZ25123891" }
        expect(response).to have_http_status(200)
        expect(JSON.parse(response.body)).to eq("country_code" => "CZ")
      end
    end
  end
end
