Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :products, only: [:index, :show, :update] do
        collection do
          get 'prices'
          get 'prices-with-discounts', to: 'products#prices_with_discounts'
        end
      end
    end
  end
end
