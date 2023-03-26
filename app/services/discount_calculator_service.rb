# frozen_string_literal: true

class DiscountCalculatorService
  include Callable

  TSHIRT_CODE = 'TSHIRT'
  MUG_CODE = 'MUG'

  def initialize(code, quantity, price)
    @code = code.upcase
    @quantity = quantity.to_i
    @price = price
  end

  def call
    case code
    when TSHIRT_CODE
      quantity >= 3 ? price * 0.7 : price
    when MUG_CODE
      discount_percentage = calculate_mug_discount(quantity)
      price * (1 - discount_percentage * 0.01)
    else
      price
    end
  end

  private

  attr_reader :code, :quantity, :price

  def calculate_mug_discount(quantity)
    return 30 if quantity >= 150

    (quantity / 10) * 2
  end
end
