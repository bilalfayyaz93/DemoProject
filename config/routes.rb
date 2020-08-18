Rails.application.routes.draw do
  resource :cart do
    member do
      patch :remove_coupen
    end
  end
  resource :receipt
  root 'products#index'
  devise_for :users do
  end

  resources :charges
  resources :orders do
  end
  resources :comments
  resources :products do
    member do
      delete :delete_image
    end
    resources :comments
  end
  resources :line_items
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
