Rails.application.routes.draw do
  root to: "home#index"
  get '/home/index', to: 'home#index'
  get '/home/test', to: 'home#test'
  get '/home/movie', to: 'home#movie'
  resources :youtube

  devise_for :users, :controllers => {
    :registrations => 'users/registrations',
    :sessions => 'users/sessions',
    omniauth_callbacks: "users/omniauth_callbacks"
  } 
  
  devise_scope :user do
    get "user/:id", :to => "users/registrations#detail"
    get "signup", :to => "users/registrations#new"
    get "login", :to => "users/sessions#new"
    get "logout", :to => "users/sessions#destroy"
  end
end
