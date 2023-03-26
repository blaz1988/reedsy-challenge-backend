# frozen_string_literal: true

class PriceCalculatorService
  include Callable

  def initialize(parser, discount_calculator = nil)
    @parser = parser
    @discount_calculator = discount_calculator
  end

  def call
    total_prices
    total_prices.values.sum
  end

  private

  attr_reader :parser, :discount_calculator

  def eligible_products
    @eligible_products ||= Product.where(code: parser.product_codes).pluck(:code, :price).to_h
  end

  def total_prices
    @total_prices ||= parser.items.each_with_object({}) do |item, total_prices|
      quantity, code = item.match(/(\d+)\s+(.+)/).captures
      code = code.upcase
      product_price = eligible_products[code]
      product_price = discount_calculator.call(code, quantity, product_price) if discount_calculator.present?
      total = product_price ? product_price * quantity.to_i : 0
      total_prices[code] = total
    end
  end
end
