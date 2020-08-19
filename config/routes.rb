Rails.application.routes.draw do
  root 'products#index'

  devise_for :users

  resource :receipt, only: [:show]
  resources :charges, only: [:new, :create]
  resources :orders , except: [:update, :edit]
  resources :comments, only: [:destroy]
  resources :line_items, only: [:create, :destroy, :update]

  resource :cart, only: [:show, :update] do
    member do
      patch :remove_coupen
    end
  end

  resources :products do
    member do
      delete :delete_image
    end

    resources :comments, only: [:create]
  end
end
