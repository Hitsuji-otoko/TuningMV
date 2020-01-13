Rails.application.routes.draw do
  root to: "home#index"
  get '/home/index', to: 'home#index'
  get '/home/test', to: 'home#test'
  get '/home/movie', to: 'home#movie'
  
  # get 'youtube/fine_playlist', to: 'youtube#fine_playlist'
  # get 'youtube/relax_playlist', to: 'youtube#relax_playlist'
  get '/youtube/match_playlist', to: 'youtube#match_playlist'
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
