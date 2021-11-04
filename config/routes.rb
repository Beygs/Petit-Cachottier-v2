Rails.application.routes.draw do
  root to: 'gossip#index'
  get '/welcome/:first_name', to: 'active_pages#welcome'
  get '/team', to: 'static_pages#team'
  get '/contact', to: 'static_pages#contact'
  resources 'gossip'
  resources 'user'
  resources 'tag', only: [:show, :create]
  resources 'city', only: [:new]
  resources 'comment'
  resources 'sessions', only: [:new, :create, :destroy]
  resources 'likes', only: [:index, :new, :create, :destroy]
end
