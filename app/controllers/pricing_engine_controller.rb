class PricingEngineController < ApplicationController
  include PricingEngineHelper
  helper_method :calc_price

  def get_price
    pet_type = Integer(request.query_parameters['pet_type'])
    duration = Integer(request.query_parameters['duration'])

    render json: { price: calc_price(pet_type, duration) }
  end
end
