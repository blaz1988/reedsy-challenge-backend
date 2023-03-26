# frozen_string_literal: true

class ProductSerializer < ActiveModel::Serializer
  attributes :id, :code, :name, :price
end
