# frozen_string_literal: true

class ProductService
  include Callable

  def new; end

  def call
    Product.all
  end
end
