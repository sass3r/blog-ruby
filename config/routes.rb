Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
    root :to => 'home#index'
    get '/malware', to: 'malware#index'
    get '/hackingzone', to: 'hacking_zone#index'
    resources :posts
    post '/posts/new', to: 'posts#create'
    post '/subscribers/new', to: 'subscriber#create'
    get 'subscribers/verify', to: 'subscriber#verify'
    devise_for :users

end
