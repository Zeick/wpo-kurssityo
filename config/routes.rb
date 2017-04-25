Rails.application.routes.draw do
  resources :styles
  resources :memberships
  resources :beer_clubs
  resources :users do
    post 'toggle_ban', on: :member
  end
  resources :beers
  resources :breweries do
    post 'toggle_activity', on: :member
  end
  resource :session, only: [:new, :create, :destroy]
  resources :ratings, only: [:index, :new, :create, :destroy]
  resources :places, only: [:index, :show]
  # Ylläoleva generoi samat polut kuin seuraavat kaksi
  # get 'places', to:'places#index'
  # get 'places/:id', to:'places#show'
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'breweries#index'
  get 'kaikki_bisset', to: 'beers#index'
  get 'signup', to: 'users#new'
  get 'signin', to: 'sessions#new'
  delete 'signout', to: 'sessions#destroy'
#  get 'places', to: 'places#index'
  post 'places', to: 'places#search'
#  get 'ratings', to: 'ratings#index'
#  get 'ratings/new', to: 'ratings#new'
#  post 'ratings', to:'ratings#create'
  get 'beerlist', to: 'beers#list'
  get 'brewerylist', to: 'breweries#list'
  get 'auth/:provider/callback', to: 'sessions#create_oauth'
end

