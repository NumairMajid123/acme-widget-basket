#!/usr/bin/env ruby
# frozen_string_literal: true

$LOAD_PATH.unshift(File.expand_path('lib', __dir__))
require 'acme_basket'

product_catalog = ProductCatalog.new([
                                       Product.new(code: 'R01', name: 'Red Widget', price: 32.95),
                                       Product.new(code: 'G01', name: 'Green Widget', price: 24.95),
                                       Product.new(code: 'B01', name: 'Blue Widget', price: 7.95)
                                     ])

shipping_calculator = ShippingCalculator.new
promotions = [RedWidgetPromotion.new]

basket = ShoppingBasket.new(product_catalog: product_catalog, shipping_calculator: shipping_calculator, promotions: promotions)

ARGV.each { |product_code| basket.add(product_code) }

puts basket.total_formatted

