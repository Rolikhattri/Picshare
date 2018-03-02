Rails.application.routes.draw do
  devise_for :users
  resources :posts do 
    collection do
      get 'dashboard'
      get 'following'
      get 'explore'
    end
  end
  resources :follows do
    collection do
      get 'follow_user'
      get 'unfollow_user' 
    end
  end
  root "posts#dashboard"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
