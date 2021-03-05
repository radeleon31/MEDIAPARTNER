Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  # get 'about', to: 'pages#about' # Revisar esta ruta de about
  get 'overview', to: 'publishings#overview'
  get 'mypublishings', to: 'publishings#mypublishings'
  get 'insight', to: 'publishings#insight'
  get 'update_publishings', to:'publishings#update_publishings'
  resources :publishings
  resources :channels, only: [:index, :show]do
    get 'last_day', on: :member
    get 'last_week', on: :member
    get 'last_month', on: :member
    get 'last_year', on: :member
  end
  # resources :channels,   do 
  #   get "last_day, on: :member"
  #   # get "last_week, on: :member"
  #   # get "last_mont, on: :member"
  #   # get "last_year, on: :member"
  # end
  #Authenticate to youtube chanel
  get '/youtube_sessions', to: 'youtube_sessions#new'
  get '/youtube_sessions/callback', to: 'youtube_sessions#callback'
end
