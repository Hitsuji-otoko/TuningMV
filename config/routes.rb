Rails.application.routes.draw do
  root to: "home#index"
  get '/home/index', to: 'home#index'
  get '/home/test', to: 'home#test'
end
