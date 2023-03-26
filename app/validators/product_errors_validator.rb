# frozen_string_literal: true

class ProductErrorsValidator
  include Callable

  def initialize(product)
    @product = product
  end

  def call
    ['Product not found!', :not_found] unless product.present?
  end

  private

  attr_reader :product
end
