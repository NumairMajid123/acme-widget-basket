# frozen_string_literal: true

require 'bigdecimal'
require 'bigdecimal/util'

class ShoppingBasket
  def initialize(product_catalog:, shipping_calculator:, promotions: [])
    @product_catalog = product_catalog
    @shipping_calculator = shipping_calculator
    @promotions = promotions
    @contents = []
  end

  def add(product_code)
    item = @product_catalog.find(product_code)
    @contents << item
  end

  def total
    base_amount = calculate_base_total
    savings = calculate_total_discounts
    final_subtotal = base_amount - savings
    shipping_cost = @shipping_calculator.compute(final_subtotal)
    round_to_two_decimals(final_subtotal + shipping_cost)
  end

  def total_formatted
    format_currency(total)
  end

  def items
    @contents.dup
  end

  private

  def calculate_base_total
    @contents.sum { |item| convert_to_decimal(item.price) }
  end

  def calculate_total_discounts
    @promotions.sum { |promo| promo.apply_discount(@contents) }
  end

  def convert_to_decimal(value)
    case value
    when BigDecimal then value
    when String then value.to_d
    else value.to_d
    end
  end

  def round_to_two_decimals(value)
    convert_to_decimal(value).round(2, BigDecimal::ROUND_HALF_DOWN)
  end

  def format_currency(amount)
    Kernel.format('$%.2f', round_to_two_decimals(amount).to_f)
  end
end
