module PricingEngineHelper extend ApplicationHelper
  include ActionView::Helpers::NumberHelper

  BASE_CHARGE = 20

  RATE_MAP = {
    1 => 10, # Dogs $10/hour
    2 => 15  # Cats $15/hour
  }

  def calc_price(pet_type, duration)
    return number_to_currency(BASE_CHARGE + duration * RATE_MAP[pet_type], unit: "$")
  end
end
