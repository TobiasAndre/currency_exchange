# frozen_string_literal: true

require "rails_helper"

describe ExchangeService do
  subject(:conversion) { described_class.new(params).perform }
  describe "#perform" do
    let(:params) do
      {
        source_currency: "BRL",
        target_currency: "EUR",
        amount: 10
      }
    end
    context "when there is a quote available" do
      let(:expected_amount) { 2.21 }

      it "returns expected amount", :vcr do
        expect(conversion).to be_eql(expected_amount)
      end
    end

    context "when the API call failed" do
      before do
        allow(RestClient).to(receive(:get).and_raise(RestClient::ExceptionWithResponse))
      end

      it "raises QuoteUnavailable" do
        expect { conversion }.to raise_error(DailyQuoteAdapter::QuoteUnavailable)
      end
    end
  end
end
