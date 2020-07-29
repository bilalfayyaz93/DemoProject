Rails.application.routes.draw do
  get 'home/index'
  root 'products#index'
  devise_for :users
  resources :products do
    member do
      delete :delete_image
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
