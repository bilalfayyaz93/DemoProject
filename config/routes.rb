Rails.application.routes.draw do
  get 'home/index'
  get 'cart', to: 'carts#index'
  root 'products#index'
  devise_for :users do
  end
  resources :charges
  resources :comments
  resources :products do
    member do
      delete :delete_image
      put :add_to_cart
      put :delete_from_cart
    end
    resources :comments
  end
  resources :line_items
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
