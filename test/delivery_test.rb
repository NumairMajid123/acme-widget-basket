# frozen_string_literal: true

require_relative 'test_helper'

class ShippingCalculatorTest < Minitest::Test
  def setup
    @calculator = ShippingCalculator.new
  end

  def test_under_50
    assert_in_delta 4.95, @calculator.compute(49.99).to_f, 0.001
  end

  def test_between_50_and_90
    assert_in_delta 2.95, @calculator.compute(50).to_f, 0.001
    assert_in_delta 2.95, @calculator.compute(89.99).to_f, 0.001
  end

  def test_free_over_90
    assert_in_delta 0.0, @calculator.compute(90).to_f, 0.001
  end
end
