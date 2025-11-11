# frozen_string_literal: true

require 'bigdecimal'
require 'bigdecimal/util'

class ShippingCalculator
  FREE_SHIPPING_THRESHOLD = BigDecimal('90')
  STANDARD_SHIPPING_THRESHOLD = BigDecimal('50')
  STANDARD_SHIPPING_COST = BigDecimal('2.95')
  BASIC_SHIPPING_COST = BigDecimal('4.95')

  def compute(order_subtotal)
    subtotal_decimal = to_decimal(order_subtotal)

    return BigDecimal('0') if subtotal_decimal >= FREE_SHIPPING_THRESHOLD
    return STANDARD_SHIPPING_COST if subtotal_decimal >= STANDARD_SHIPPING_THRESHOLD

    BASIC_SHIPPING_COST
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
