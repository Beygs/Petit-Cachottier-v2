Rails.application.routes.draw do
  root to: 'gossip#index'
  get '/welcome/:first_name', to: 'active_pages#welcome'
  get '/team', to: 'static_pages#team'
  get '/contact', to: 'static_pages#contact'
  resources 'gossip'
  resources 'user'
  resources 'tag'
  resources 'city'
  resources 'comment'
  resources 'sessions', only: [:new, :create, :destroy]
end
