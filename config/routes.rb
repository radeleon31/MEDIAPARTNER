Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: "users/sessions" }
  root to: 'pages#home'
  # get 'about', to: 'pages#about' # Revisar esta ruta de about
  get 'overview', to: 'publishings#overview'
  get 'mypublishings', to: 'publishings#mypublishings'
  get 'insight', to: 'publishings#insight'
  get 'update_publishings', to:'publishings#update_publishings'
  resources :publishings
  resources :channels, only: [:index, :show]
  get 'last_day', to: 'channels#last_day'
  get 'last_week', to: 'channels#last_week'
  get 'last_month', to: 'channels#last_month'
  get 'last_year', to: 'channels#last_year'
  

  get '/youtube_sessions', to: 'youtube_sessions#new'
  get '/youtube_sessions/callback', to: 'youtube_sessions#callback'
end
