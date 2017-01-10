Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root "auctions#index"
  resources :auctions do
    resources :bids, only: [:create, :destory]
    resources :publishings, only:[:create]
  end
  resources :users, only: [:new, :create]

  resources :sessions, only: [:new, :create] do
    delete :destroy, on: :collection
  end



end
