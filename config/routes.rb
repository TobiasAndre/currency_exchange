# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  scope :api do
    get "datetime/current", to: "information#datetime"
    get "currency/convert", to: "exchanges#convert_currencies"
    get "validators/validate_vat", to: "validators#validate_vat"
  end
end
