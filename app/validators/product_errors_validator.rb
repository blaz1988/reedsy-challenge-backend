# frozen_string_literal: true

class ProductErrorsValidator
  include Callable

  def initialize(product)
    @product = product
  end

  def call
    return ['Product not found!', :not_found] unless product.present?

    [product.errors.full_messages.join(','), :unprocessable_entity] if errors?
  end

  private

  attr_reader :product

  def errors?
    product&.errors&.any?
  end
end
