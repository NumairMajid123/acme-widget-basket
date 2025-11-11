# frozen_string_literal: true

require 'bigdecimal'
require 'bigdecimal/util'
require_relative 'promotion'

# This promotion class can be extended for other widget types.
# Additional promotions can follow the same pattern.

class RedWidgetPromotion < Promotion
  RED_WIDGET_CODE = 'R01'
  DISCOUNT_PERCENTAGE = BigDecimal('0.5')

  def apply_discount(basket_items)
    red_widgets = basket_items.select { |item| item.code == RED_WIDGET_CODE }
    return BigDecimal('0') if red_widgets.empty?

    unit_price = to_decimal(red_widgets.first.price)
    eligible_pairs = red_widgets.count / 2
    # Rounding handled by ShoppingBasket
    eligible_pairs * (unit_price * DISCOUNT_PERCENTAGE)
  end

  private

  def to_decimal(value)
    case value
    when BigDecimal then value
    when String then value.to_d
    else value.to_d
    end
  end
end

