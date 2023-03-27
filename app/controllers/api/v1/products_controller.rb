# frozen_string_literal: true

module Api
  module V1
    class ProductsController < ApplicationController
      before_action :set_product, only: %i[show update]
      before_action :authenticate, only: [:update]

      def index
        @products = ProductService.call

        render json: @products, each_serializer: ProductSerializer
      end

      def show
        error, status = ProductErrorsValidator.call(@product)
        if error.present?
          render(json: { error: }, status:)
        else
          render(json: @product, serializer: ProductSerializer)
        end
      end

      def update
        @product = UpdateProductService.call(@product, update_product_params)
        error, status = ProductErrorsValidator.call(@product)
        if error.present?
          render(json: { error: }, status:)
        else
          render(json: @product, serializer: ProductSerializer)
        end
      end

      def prices
        parser = ProductParamsParser.new(params[:items])

        if parser.error.present?
          render json: { error: parser.error }, status: :bad_request
        else
          total_price = PriceCalculatorService.call(parser)
          render json: { total: total_price }
        end
      end

      def prices_with_discounts
        parser = ProductParamsParser.new(params[:items])

        if parser.error.present?
          render json: { error: parser.error }, status: :bad_request
        else
          total_price = PriceCalculatorService.call(parser, DiscountCalculatorService)
          render json: { total: total_price }
        end
      end

      private

      def set_product
        @product = Product.find_by(id: params[:id])
      end

      def product_params
        params.require(:product).permit(:code, :name, :price)
      end

      def update_product_params
        params.require(:product).permit(:price)
      end

      def authenticate
        return if AuthenticationService.authenticate?(request)

        render json: { error: 'Unauthorized' }, status: :unauthorized
      end
    end
  end
end
