# frozen_string_literal: true

require_relative 'test_helper'

class ShoppingBasketTest < Minitest::Test
  def setup
    @basket = ShoppingBasket.new(product_catalog: default_catalogue, shipping_calculator: default_shipping_calculator, promotions: default_promotions)
  end

  def test_b01_g01
    @basket.add('B01')
    @basket.add('G01')
    assert_in_delta 37.85, @basket.total.to_f, 0.001
  end

  def test_r01_r01
    @basket.add('R01')
    @basket.add('R01')
    assert_in_delta 54.37, @basket.total.to_f, 0.001
  end

  def test_r01_g01
    @basket.add('R01')
    @basket.add('G01')
    assert_in_delta 60.85, @basket.total.to_f, 0.001
  end

  def test_mixed
    %w[B01 B01 R01 R01 R01].each { |code| @basket.add(code) }
    assert_in_delta 98.27, @basket.total.to_f, 0.001
  end

  def test_unknown_product
    assert_raises(ArgumentError) { @basket.add('TestingProduct') }
  end
end
