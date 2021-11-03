Rails.application.routes.draw do
  root to: 'static_pages#home'
  get '/welcome/:first_name', to: 'active_pages#welcome'
  get '/team', to: 'static_pages#team'
  get '/contact', to: 'static_pages#contact'
  resources 'gossip'
  resources 'user'
  resources 'tag'
  resources 'city'
end
