# frozen_string_literal: true

require "rails_helper"

describe ExchangesController, type: :request do
  describe "GET #convert" do
    context "when params is missing" do
      it "return unprocessable entity (422)", :vcr do
        get "/api/currency/convert", params: {}
        expect(response).to have_http_status(422)
      end
    end

    context "when request with valid params" do
      let(:exchange_params) { { source_currency: "USD", target_currency: "BRL", amount: 10 } }
      it "return valid quote and status 200", :vcr do
        get "/api/currency/convert", params: exchange_params
        expect(response).to have_http_status(200)
      end
    end

    context "when a failure occurs" do
      let(:exchange_params) { { source_currency: 1, target_currency: 2, amount: -1 } }
      it "rescue QuoteUnavailable", :vcr do
        get "/api/currency/convert", params: exchange_params
      end
    end
  end
end
