# frozen_string_literal: true

require "rails_helper"

describe InformationController, type: :request do
  describe "#datetime" do
    context "when a request for datetime is called" do
      it "return current datetime" do
        get "/api/datetime/current", params: {}
        expect(response).to have_http_status(200)
      end
    end
  end
end
