Rails.application.routes.draw do
  root 'products#index'

  devise_for :users

  resources :charges, only: [:new, :create]
  resources :orders , only: [:index, :show, :new]
  resources :line_items, only: [:create, :destroy, :update]

  resource :cart, only: [:show, :update] do
    member do
      patch :remove_coupon
    end
  end

  resources :products do
    member do
      delete :purge_image
    end

    collection do
      get :user_products
    end
    resources :comments, shallow: true, only: [:create,:destroy]
  end
end
