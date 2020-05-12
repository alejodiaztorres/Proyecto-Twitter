Rails.application.routes.draw do
  get '/tweets/:id/retweets', to: 'tweets#retweets', as: 'retweets'
  resources :tweets do
    resources :likes
    member do
      post :retweet
    end
  end

  
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  resources :tweets do
    resources :likes
  end


  namespace :api do
    resources :news, only: [:index, :create, :destroy, :update, :show]
    resources :tweets, only: [:create]
  end

  get '/api/:date1/:date2', to: 'tweets#date', as: "date"

  devise_for :users, :controllers => {registrations: 'registrations'}

  root 'tweets#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
