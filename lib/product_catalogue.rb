# frozen_string_literal: true

class ProductCatalog
  def initialize(product_list = [])
    @products_by_code = {}
    product_list.each { |product| register(product) }
  end

  def register(product)
    @products_by_code[product.code] = product
  end

  def find(product_code)
    @products_by_code.fetch(product_code) { raise ArgumentError, "Unknown product code: #{product_code}" }
  end
end
