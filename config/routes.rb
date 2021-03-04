Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: "users/sessions" }
  root to: 'pages#home'
  get 'about', to: 'pages#about' # Revisar esta ruta de about
  get 'overview', to: 'publishings#overview'
  get 'mypublishings', to: 'publishings#mypublishings'
  get 'insight', to: 'publishings#insight'
  resources :publishings
  resources :channels, only: [:show]
  #Authenticate to youtube chanel
  get '/youtube_sessions', to: 'youtube_sessions#new'
  get '/youtube_sessions/callback', to: 'youtube_sessions#callback'
end
