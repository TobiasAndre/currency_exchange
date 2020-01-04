# frozen_string_literal: true

class InformationController < ApplicationController
  def datetime
    render json: { "current": DateTime.current }
  end
end
