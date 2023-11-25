Rails.application.routes.draw do
  root to: "homes#top"
  get "home/about" =>  "homes#about", as: "about"
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :users, only: [:edit, :index, :show, :updete]
  resources :books, only: [:index, :show, :edit, :create, :updete, :destroy]
  
end
