# frozen_string_literal: true

class UpdateProductService
  include Callable

  def initialize(product, update_params)
    @product = product
    @update_params = update_params
  end

  def call
    product.update(update_params)
    product
  end

  private

  attr_reader :product, :update_params
end
