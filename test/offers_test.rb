# frozen_string_literal: true

require_relative 'test_helper'

class PromotionsTest < Minitest::Test
  def setup
    @promotion = RedWidgetPromotion.new
    @red_widget = Product.new(code: 'R01', name: 'Red', price: 32.95)
    @blue_widget = Product.new(code: 'B01', name: 'Blue', price: 7.95)
  end

  def test_no_discount_under_two
    assert_in_delta 0.0, @promotion.apply_discount([@red_widget]).to_f, 0.001
  end

  def test_half_off_second
    two_reds = [@red_widget, @red_widget]
    assert_in_delta 16.48, @promotion.apply_discount(two_reds).to_f, 0.01
  end

  def test_ignores_others
    assert_in_delta 0.0, @promotion.apply_discount([@blue_widget, @blue_widget]).to_f, 0.001
  end

  def test_three_reds
    three_reds = [@red_widget, @red_widget, @red_widget]
    assert_in_delta 16.48, @promotion.apply_discount(three_reds).to_f, 0.01
  end

  def test_four_reds
    four_reds = [@red_widget, @red_widget, @red_widget, @red_widget]
    assert_in_delta 32.95, @promotion.apply_discount(four_reds).to_f, 0.01
  end
end
