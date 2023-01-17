Rails.application.routes.draw do
  
  root "photos#index"
  
  devise_for :users
  
  
  
  resources :likes
  resources :follow_requests
  resources :comments
  resources :photos
  resources :users, only: :show

  get ":username/liked" => "photos#liked", as: :liked_photos
  #get ":username/feed" => "photos#liked", as: :liked_photos
  get ":username/followers" => "users#followers", as: :followers # list group
  get ":username/leaders" => "users#leaders", as: :leaders # list group

  get ":username" => "users#show"
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
