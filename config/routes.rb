Rails.application.routes.draw do
  devise_for :users, :controllers => {registrations: 'registrations'}
  get '/tweets/:id/retweets', to: 'tweets#retweets', as: 'retweets'
  resources :tweets do
    resources :likes
    member do
      post :retweet
    end
    
  end
  root 'tweets#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
