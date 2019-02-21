Rails.application.routes.draw do
  root 'pages#index', as: 'home'
  get 'about' => 'pages#about', as: 'about'
  
  get 'movies' => 'movies#list', as: 'movies'
  get '/movies/:id', to: 'movies#show', as: 'show_movie'
  
  get 'reviews' => 'reviews#show', as: 'reviews'
  get 'reviews/new/:id' => 'reviews#new', as: 'new_review'
  post 'reviews/create/:id' => 'reviews#create', as: 'create_review'
end
