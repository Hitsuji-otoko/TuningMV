Rails.application.routes.draw do
  get '/', to: 'home#index'
  get '/home/index', to: 'home#index'
end
