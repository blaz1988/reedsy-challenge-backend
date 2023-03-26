# frozen_string_literal: true

class ProductParamsParser
  attr_reader :item_params

  def initialize(item_params)
    @item_params = item_params
  end

  def items
    @items ||= item_params.split(',').map(&:strip)
  end

  def product_codes
    items.map { |i| i.split(' ').second }
  end

  def error
    'Invalid params!' unless valid?
  end

  private

  def valid?
    contains_digit_space_letter && contains_comma && contains_space
  end

  def contains_digit_space_letter
    item_params =~ /(\d+)\s+(.+)/
  end

  def contains_comma
    item_params.include?(',')
  end

  def contains_space
    item_params.include?(' ')
  end
end
